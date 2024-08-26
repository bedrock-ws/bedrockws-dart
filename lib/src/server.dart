import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bedrockws/bedrockws.dart';
import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_web_socket/shelf_web_socket.dart';

class BedrockServer {
  final log = Logger('BedrockServer');
  final List<Client> _clients = [];
  bool _ready = false;

  EventHandler<ConnectContext>? _eventHandlerConnect;
  EventHandler<DisconnectContext>? _eventHandlerDisconnect;
  EventHandler<ReadyContext>? _eventHandlerReady;

  // EventHandler<AdditionalContentLoadedContext>?
  //     _eventHandlerAdditionalContentLoaded;
  // EventHandler<AgentCommandContext>? _eventHandlerAgentCommand;
  // EventHandler<AgentCreatedContext>? _eventHandlerAgentCreated;
  // EventHandler<ApiInitContext>? _eventHandlerApiInit;
  // EventHandler<AppPausedContext>? _eventHandlerAppPaused;
  // EventHandler<AppResumedContext>? _eventHandlerAppResumed;
  // EventHandler<AppSuspendedContext>? _eventHandlerAppSuspended;
  // EventHandler<AwardAchievementContext>? _eventHandlerAwardAchievement;
  EventHandler<BlockBrokenContext>? _eventHandlerBlockBroken;
  EventHandler<BlockPlacedContext>? _eventHandlerBlockPlaced;
  // EventHandler<BoardTextUpdateContext>? _eventHandlerBoardTextUpdate;
  // EventHandler<BossKilledContext>? _eventHandlerBossKilled;
  // EventHandler<CameraUsedContext>? _eventHandlerCameraUsed;
  // EventHandler<CauldronUsedContext>? _eventHandlerCauldronUsed;
  // EventHandler<ConfigurationChangedContext>? _eventHandlerConfigurationChanged;
  // EventHandler<ConnectionFailedContext>? _eventHandlerConnectionFailed;
  // EventHandler<CraftingSessionCompletedContext>?
  //     _eventHandlerCraftingSessionCompleted;
  // EventHandler<EndOfDayContext>? _eventHandlerEndOfDay;
  // EventHandler<EntitySpawnedContext>? _eventHandlerEntitySpawned;
  // EventHandler<FileTransmissionCancelledContext>?
  //     _eventHandlerFileTransmissionCancelled;
  // EventHandler<FileTransmissionCompletedContext>?
  //     _eventHandlerFileTransmissionCompleted;
  // EventHandler<FileTransmissionStartedContext>?
  //     _eventHandlerFileTransmissionStarted;
  // EventHandler<FirstTimeClientOpenContext>? _eventHandlerFirstTimeClientOpen;
  // EventHandler<FocusGainedContext>? _eventHandlerFocusGained;
  // EventHandler<FocusLostContext>? _eventHandlerFocusLost;
  // EventHandler<GameSessionCompleteContext>? _eventHandlerGameSessionComplete;
  // EventHandler<GameSessionStartContext>? _eventHandlerGameSessionStart;
  // EventHandler<HardwareInfoContext>? _eventHandlerHardwareInfo;
  // EventHandler<HasNewContentContext>? _eventHandlerHasNewContent;
  // EventHandler<ItemAcquiredContext>? _eventHandlerItemAcquired;
  // EventHandler<ItemCraftedContext>? _eventHandlerItemCrafted;
  // EventHandler<ItemDestroyedContext>? _eventHandlerItemDestroyed;
  // EventHandler<ItemDroppedContext>? _eventHandlerItemDropped;
  // EventHandler<ItemEnchantedContext>? _eventHandlerItemEnchanted;
  // EventHandler<ItemSmeltedContext>? _eventHandlerItemSmelted;
  // EventHandler<ItemUsedContext>? _eventHandlerItemUsed;
  // EventHandler<JoinCanceledContext>? _eventHandlerJoinCanceled;
  // EventHandler<JukeboxUsedContext>? _eventHandlerJukeboxUsed;
  // EventHandler<LicenseCensusContext>? _eventHandlerLicenseCensus;
  // EventHandler<MascotCreatedContext>? _eventHandlerMascotCreated;
  // EventHandler<MenuShownContext>? _eventHandlerMenuShown;
  // EventHandler<MobInteractedContext>? _eventHandlerMobInteracted;
  // EventHandler<MobKilledContext>? _eventHandlerMobKilled;
  // EventHandler<MultiplayerConnectionStateChangedContext>?
  //     _eventHandlerMultiplayerConnectionStateChanged;
  // EventHandler<MultiplayerRoundEndContext>? _eventHandlerMultiplayerRoundEnd;
  // EventHandler<MultiplayerRoundStartContext>?
  //     _eventHandlerMultiplayerRoundStart;
  // EventHandler<NpcPropertiesUpdatedContext>? _eventHandlerNpcPropertiesUpdated;
  // EventHandler<OptionsUpdatedContext>? _eventHandlerOptionsUpdated;
  // EventHandler<PerformanceMetricsContext>? _eventHandlerPerformanceMetrics;
  // EventHandler<PlayerBouncedContext>? _eventHandlerPlayerBounced;
  // EventHandler<PlayerDiedContext>? _eventHandlerPlayerDied;
  // EventHandler<PlayerJoinContext>? _eventHandlerPlayerJoin;
  // EventHandler<PlayerLeaveContext>? _eventHandlerPlayerLeave;
  EventHandler<PlayerMessageContext>? _eventHandlerPlayerMessage;
  // EventHandler<PlayerTeleportedContext>? _eventHandlerPlayerTeleported;
  // EventHandler<PlayerTransformContext>? _eventHandlerPlayerTransform;
  // EventHandler<PlayerTravelledContext>? _eventHandlerPlayerTravelled;
  // EventHandler<PortalBuiltContext>? _eventHandlerPortalBuilt;
  // EventHandler<PortalUsedContext>? _eventHandlerPortalUsed;
  // EventHandler<PortfolioExportedContext>? _eventHandlerPortfolioExported;
  // EventHandler<PotionBrewedContext>? _eventHandlerPotionBrewed;
  // EventHandler<PurchaseAttemptContext>? _eventHandlerPurchaseAttempt;
  // EventHandler<PurchaseResolvedContext>? _eventHandlerPurchaseResolved;
  // EventHandler<RegionalPopupContext>? _eventHandlerRegionalPopup;
  // EventHandler<RespondedToAcceptContentContext>?
  //     _eventHandlerRespondedToAcceptContent;
  // EventHandler<ScreenChangedContext>? _eventHandlerScreenChanged;
  // EventHandler<ScreenHeartbeatContext>? _eventHandlerScreenHeartbeat;
  // EventHandler<SignInToEduContext>? _eventHandlerSignInToEdu;
  // EventHandler<SignInToXboxLiveContext>? _eventHandlerSignInToXboxLive;
  // EventHandler<SignOutOfXboxLiveContext>? _eventHandlerSignOutOfXboxLive;
  // EventHandler<SpecialMobBuiltContext>? _eventHandlerSpecialMobBuilt;
  // EventHandler<StartClientContext>? _eventHandlerStartClient;
  // EventHandler<StartWorldContext>? _eventHandlerStartWorld;
  // EventHandler<TextToSpeechToggledContext>? _eventHandlerTextToSpeechToggled;
  // EventHandler<UgcDownloadCompletedContext>? _eventHandlerUgcDownloadCompleted;
  // EventHandler<UgcDownloadStartedContext>? _eventHandlerUgcDownloadStarted;
  // EventHandler<UploadSkinContext>? _eventHandlerUploadSkin;
  // EventHandler<VehicleExitedContext>? _eventHandlerVehicleExited;
  // EventHandler<WorldExportedContext>? _eventHandlerWorldExported;
  // EventHandler<WorldFilesListedContext>? _eventHandlerWorldFilesListed;
  // EventHandler<WorldGeneratedContext>? _eventHandlerWorldGenerated;
  // EventHandler<WorldLoadedContext>? _eventHandlerWorldLoaded;
  // EventHandler<WorldUnloadedContext>? _eventHandlerWorldUnloaded;

  List<Client> get clients => _clients;

  Future<void> _processData(Client client, dynamic data) async {
    final Map header = data['header'];
    final Map body = data['body'];
    final bool isResponse = header['messagePurpose'] == 'commandResponse';
    final bool isError = header['messagePurpose'] == 'error';

    final String? eventName = header['eventName'];
    if (eventName != null) {
      switch (eventName) {
        case 'BlockBroken':
          await _triggerBlockBroken(BlockBrokenContext(
            this,
            client,
            data,
          ));
        case 'BlockPlaced':
          await _triggerBlocPlaced(BlockPlacedContext(
            this,
            client,
            data,
          ));
        case 'PlayerMessage':
          await _triggerPlayerMessage(PlayerMessageContext(
            this,
            client,
            data,
          ));
        // TODO
      }
    }

    if (isResponse) {
      client.commandProcessingSemaphore.release();
      final identifier = header['requestId']!;
      for (final req in client.requests) {
        if (req.identifier == identifier) {
          if (isError) {
            req.rawResponse.completeError(body['statusMessage']);
          } else {
            final res =
                CommandResponse(body['statusMessage'], body['statusCode']);
            req.rawResponse.complete(res);
          }
          client.requests.remove(req);
        }
      }
    }
  }

  /// Returns whether at least one client is connected to the server.
  bool get connected => _clients.isNotEmpty;

  /// Returns whether a connection with the server can be established.
  bool get ready => _ready;

  FutureOr<Response> Function(Request) _handler() {
    return webSocketHandler((webSocket) async {
      final Client client = Client(this, webSocket);
      log.finest(client);
      _clients.add(client);
      log.finest(_clients);
      await _triggerConnect(ConnectContext(this, client));

      // TODO
      if (_eventHandlerBlockBroken != null) {
        client.subscribe(Event.blockBroken);
      }
      if (_eventHandlerBlockPlaced != null) {
        client.subscribe(Event.blockPlaced);
      }
      if (_eventHandlerPlayerMessage != null) {
        client.subscribe(Event.playerMessage);
      }

      await webSocket.stream.listen(
        (message) async {
          log.fine('Received message: $message');
          final data = jsonDecode(message);
          log.fine('Received data: $data');
          await _processData(client, data);
        },
        onDone: () {
          _clients.remove(client);
          log.fine('Client disconnected');
          _triggerDisconnect(DisconnectContext(this, client));
        },
        onError: (error) {
          _clients.remove(client);
          log.severe('Error: $error');
        },
      );
    });
  }

  Future<void> _triggerConnect(ConnectContext ctx) async {
    final handler = _eventHandlerConnect;
    if (handler != null) await handler(ctx);
  }

  Future<void> _triggerDisconnect(DisconnectContext ctx) async {
    final handler = _eventHandlerDisconnect;
    if (handler != null) await handler(ctx);
  }

  Future<void> _triggerReady(ReadyContext ctx) async {
    _ready = true;
    final handler = _eventHandlerReady;
    if (handler != null) await handler(ctx);
  }

  Future<void> _triggerBlockBroken(BlockBrokenContext ctx) async {
    final handler = _eventHandlerBlockBroken;
    if (handler != null) await handler(ctx);
  }

  Future<void> _triggerBlocPlaced(BlockPlacedContext ctx) async {
    final handler = _eventHandlerBlockPlaced;
    if (handler != null) await handler(ctx);
  }

  Future<void> _triggerPlayerMessage(PlayerMessageContext ctx) async {
    final handler = _eventHandlerPlayerMessage;
    if (handler != null) await handler(ctx);
  }

  void onConnect(EventHandler<ConnectContext> callback) {
    _eventHandlerConnect = callback;
  }

  void onDisconnect(EventHandler<DisconnectContext> callback) {
    _eventHandlerDisconnect = callback;
  }

  void onReady(EventHandler<ReadyContext> callback) {
    _eventHandlerReady = callback;
  }

  // TODO

  void onBlockBroken(EventHandler<BlockBrokenContext> callback) {
    _eventHandlerBlockBroken = callback;
  }

  void onBlockPlaced(EventHandler<BlockPlacedContext> callback) {
    _eventHandlerBlockPlaced = callback;
  }

  void onPlayerMessage(EventHandler<PlayerMessageContext> callback) {
    _eventHandlerPlayerMessage = callback;
  }

  /// Starts the Web Socket server.
  Future<void> serve(InternetAddress address, int port) async {
    await shelf_io.serve(_handler(), address, port).then((server) async {
      await _triggerReady(ReadyContext(this, address, port));
    });
  }
}

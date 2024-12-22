/// The amount of command request that can be stored in Minecraft's processing
/// queue at once.
const maxCommandProcessing = 100;

/// The name of the server when sending messages.
@Deprecated("`name` only works for languages `nl_NL`, `en_US`, `sv_SE`, and `de_DE`. Use `names` instead.")
const name = 'Extern';

/// The name of the server when sending messages depending on the language.
const names = {
  'nl_NL': 'Extern',
  'fr_CA': 'Externe',
  'it_IT': 'Esterno',
  'nb_NO': 'Ekstern',
  'fi_FI': 'Ulkoinen',
  'en_US': 'Extern',
  'es_ES': 'Externo',
  'ru_RU': 'Внешний',
  'zh_CN': '外部',
  'cs_CZ': 'Externí',
  'da_DK': 'Ekstern',
  'es_MX': 'Externo',
  'th_TW': '外部',
  'bg_BG': 'Външен',
  'uk_UA': 'Зовнішні',
  'sk_SK': 'Externý',
  'pt_PT': 'Exterior',
  'en_GB': 'External',
  'pl_PL': 'Zewnętrzny',
  'sv_SE': 'Extern',
  'tr_TR': 'Harici',
  'id_ID': 'Eksternal',
  'pt_BR': 'Externo',
  'hu_HU': 'Külső',
  'ko_KR': '외부',
  'fr_FR': 'Externe',
  'el_GR': 'Εξωτερικό',
  'de_DE': 'Extern',
  'ja_JP': '外部',
};

/// The version of Minecraft used for the command system.
const minecraftVersion = '1.21.0';

/// The prefix used for Minecraft commands.
const commandPrefix = '/';

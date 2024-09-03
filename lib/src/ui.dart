/// Chat UI related things like text formatting and icons.
library;

/// The prefix required to enable styles.
const prefix = '§';

const _reset = '${prefix}r';

/// Removes redundant codes like `§a§l` in `§a§l§r`.
String removeRedundantCodes(String string) {
  while (true) {
    int index = string.lastIndexOf(_reset);
    if (index < 0) {
      return string;
    }
    int redundantCodes = 0;
    while (string[index - 2] == prefix) {
      redundantCodes++;
      index -= 2;
    }
    if (redundantCodes == 0) {
      return string;
    }
    string = string.substring(0, index) +
        string.substring(index + redundantCodes * 2);
  }
}

abstract class Style {
  String draw();

  @override
  String toString() => '$prefix${draw()}';
}

abstract class Color extends Style {}

abstract class Icon {
  String draw();

  @override
  String toString() => draw();
}

class TextStyle {
  TextStyle({
    this.color,
    this.bold = false,
    this.italic = false,
    this.obfuscated = false,
  });

  final Color? color;
  final bool bold;
  final bool italic;
  final bool obfuscated;

  String enable() => '${color?.draw() ?? ''}'
      '${bold ? Bold().draw() : ''}'
      '${italic ? Italic().draw() : ''}'
      '${obfuscated ? Obfuscated().draw() : ''}';
}

class TextSpan {
  TextSpan({this.text, this.children = const [], this.style});

  final String? text;
  final List<TextSpan> children;
  final TextStyle? style;

  // FIXME

  String _render({TextStyle? restore}) {
    var result = '';
    if (style != null) {
      result += style!.enable();
    }
    if (text != null) {
      result += text!;
    }
    for (final child in children) {
      result += child.toString();
    }
    result += '§r';
    if (restore != null) {
      result += restore.enable();
    }
    return result;
  }

  @override
  String toString() =>
      removeRedundantCodes('${_render(restore: style)}$_reset');
}

class Black extends Color {
  @override
  String draw() => '${prefix}0';
}

class DarkBlue extends Color {
  @override
  String draw() => '${prefix}1';
}

class DarkGreen extends Color {
  @override
  String draw() => '${prefix}2';
}

class DarkAqua extends Color {
  @override
  String draw() => '${prefix}3';
}

class DarkRed extends Color {
  @override
  String draw() => '${prefix}4';
}

class DarkPurple extends Color {
  @override
  String draw() => '${prefix}5';
}

class Gold extends Color {
  @override
  String draw() => '${prefix}6';
}

class Gray extends Color {
  @override
  String draw() => '${prefix}7';
}

class DarkGray extends Color {
  @override
  String draw() => '${prefix}8';
}

class Blue extends Color {
  @override
  String draw() => '${prefix}9';
}

class Green extends Color {
  @override
  String draw() => '${prefix}a';
}

class Aqua extends Color {
  @override
  String draw() => '${prefix}b';
}

class Red extends Color {
  @override
  String draw() => '${prefix}c';
}

class LightPurple extends Color {
  @override
  String draw() => '${prefix}d';
}

class Yellow extends Color {
  @override
  String draw() => '${prefix}e';
}

class White extends Color {
  @override
  String draw() => '${prefix}f';
}

class MinecoinGold extends Color {
  @override
  String draw() => '${prefix}g';
}

class MaterialQuartz extends Color {
  @override
  String draw() => '${prefix}h';
}

class MaterialIron extends Color {
  @override
  String draw() => '${prefix}i';
}

class MaterialRedstrone extends Color {
  @override
  String draw() => '${prefix}m';
}

class MaterialCopper extends Color {
  @override
  String draw() => '${prefix}n';
}

class MaterialNetherite extends Color {
  @override
  String draw() => '${prefix}j';
}

class MaterialGold extends Color {
  @override
  String draw() => '${prefix}p';
}

class MaterialEmerald extends Color {
  @override
  String draw() => '${prefix}q';
}

class MaterialDiamond extends Color {
  @override
  String draw() => '${prefix}s';
}

class MaterialLapis extends Color {
  @override
  String draw() => '${prefix}t';
}

class MaterialAmethyst extends Color {
  @override
  String draw() => '${prefix}u';
}

class Obfuscated extends Style {
  @override
  String draw() => '${prefix}k';
}

class Bold extends Style {
  @override
  String draw() => '${prefix}l';
}

class Italic extends Style {
  @override
  String draw() => '${prefix}o';
}

class XboxAButton extends Icon {
  @override
  String draw() => '\uE000';
}

class XboxBButton extends Icon {
  @override
  String draw() => '\ue001';
}

class XboxXButton extends Icon {
  @override
  String draw() => '\ue002';
}

class XboxYButton extends Icon {
  @override
  String draw() => '\ue003';
}

class XboxLButton extends Icon {
  @override
  String draw() => '\ue004';
}

class XboxRBButton extends Icon {
  @override
  String draw() => '\ue005';
}

class XboxLBButton extends Icon {
  @override
  String draw() => '\ue006';
}

class XboxRTButton extends Icon {
  @override
  String draw() => '\ue007';
}

class XboxSelectButton extends Icon {
  @override
  String draw() => '\ue008';
}

class XboxStartButton extends Icon {
  @override
  String draw() => '\ue009';
}

class XboxLeftStickButton extends Icon {
  @override
  String draw() => '\ue00a';
}

class XboxRightStickButton extends Icon {
  @override
  String draw() => '\ue00b';
}

class XboxDPadUpButton extends Icon {
  @override
  String draw() => '\ue00c';
}

class XboxDPadLeftButton extends Icon {
  @override
  String draw() => '\ue00d';
}

class XboxDPadDownButton extends Icon {
  @override
  String draw() => '\ue00e';
}

class XboxDPadRightButton extends Icon {
  @override
  String draw() => '\ue00f';
}

class MobileJump extends Icon {
  @override
  String draw() => '\ue014';
}

class MobileAttack extends Icon {
  @override
  String draw() => '\ue015';
}

class MobileJoyStick extends Icon {
  @override
  String draw() => '\ue016';
}

class MobileCrossHair extends Icon {
  @override
  String draw() => '\ue017';
}

class PlaystationCrossButton extends Icon {
  @override
  String draw() => '\ue020';
}

class PlaystationCircleButton extends Icon {
  @override
  String draw() => '\ue021';
}

class PlaystationSquareButton extends Icon {
  @override
  String draw() => '\ue022';
}

class PlaystationTriangleButton extends Icon {
  @override
  String draw() => '\ue023';
}

class PlaystationL1Button extends Icon {
  @override
  String draw() => '\ue024';
}

class PlaystationR1Button extends Icon {
  @override
  String draw() => '\ue025';
}

class PlaystationL2Button extends Icon {
  @override
  String draw() => '\ue026';
}

class PlaystationR2Button extends Icon {
  @override
  String draw() => '\ue027';
}

class PlaystationSelectButton extends Icon {
  @override
  String draw() => '\ue028';
}

class PlaystationStartButton extends Icon {
  @override
  String draw() => '\ue029';
}

class PlaystationLeftStickButton extends Icon {
  @override
  String draw() => '\ue02a';
}

class PlaystationRightStickButton extends Icon {
  @override
  String draw() => '\ue02b';
}

class PlaystationDPadUpButton extends Icon {
  @override
  String draw() => '\ue02c';
}

class PlaystationDPadLeftButton extends Icon {
  @override
  String draw() => '\ue02d';
}

class PlaystationDPadDownButton extends Icon {
  @override
  String draw() => '\ue02e';
}

class PlaystationDPadRightButton extends Icon {
  @override
  String draw() => '\ue02f';
}

class SwitchAButton extends Icon {
  @override
  String draw() => '\ue040';
}

class SwitchBButton extends Icon {
  @override
  String draw() => '\ue041';
}

class SwitchXButton extends Icon {
  @override
  String draw() => '\ue042';
}

class SwitchYButton extends Icon {
  @override
  String draw() => '\ue043';
}

class SwitchLButton extends Icon {
  @override
  String draw() => '\ue044';
}

class SwitchRButton extends Icon {
  @override
  String draw() => '\ue045';
}

class SwitchZlButton extends Icon {
  @override
  String draw() => '\ue046';
}

class SwitchZrButton extends Icon {
  @override
  String draw() => '\ue047';
}

class SwitchMinusButton extends Icon {
  @override
  String draw() => '\ue048';
}

class SwitchPlusButton extends Icon {
  @override
  String draw() => '\ue049';
}

class SwitchLeftStickButton extends Icon {
  @override
  String draw() => '\ue04a';
}

class SwitchRightStickButton extends Icon {
  @override
  String draw() => '\ue04b';
}

class SwitchDPadUpButton extends Icon {
  @override
  String draw() => '\ue04c';
}

class SwitchDPadLeftButton extends Icon {
  @override
  String draw() => '\ue04d';
}

class SwitchDPadDownButton extends Icon {
  @override
  String draw() => '\ue04e';
}

class SwitchDPadRightButton extends Icon {
  @override
  String draw() => '\ue04f';
}

class MobileSmallJumpButton extends Icon {
  @override
  String draw() => '\ue059';
}

class MobileSmallCrouchButton extends Icon {
  @override
  String draw() => '\ue05a';
}

class MobileSmallFlyUpButton extends Icon {
  @override
  String draw() => '\ue05c';
}

class MobileSmallFlyDownButton extends Icon {
  @override
  String draw() => '\ue05d';
}

class MobileSmallLeftArrowButton extends Icon {
  @override
  String draw() => '\ue056';
}

class MobileSmallRightArrowButton extends Icon {
  @override
  String draw() => '\ue058';
}

class MobileSmallUpArrowButton extends Icon {
  @override
  String draw() => '\ue055';
}

class MobileSmallDownArrowButton extends Icon {
  @override
  String draw() => '\ue057';
}

class MobileSmallInventoryButton extends Icon {
  @override
  String draw() => '\ue05b';
}

class WindowsLeftMouseButton extends Icon {
  @override
  String draw() => '\ue060';
}

class WindowsRightMouseButton extends Icon {
  @override
  String draw() => '\ue061';
}

class WindowsMiddleMouseButton extends Icon {
  @override
  String draw() => '\ue062';
}

class MobileForwardArrowButton extends Icon {
  @override
  String draw() => '\ue080';
}

class MobileLeftArrowButton extends Icon {
  @override
  String draw() => '\ue081';
}

class MobileBackwardsArrowButton extends Icon {
  @override
  String draw() => '\ue082';
}

class MobileRightArrowButton extends Icon {
  @override
  String draw() => '\ue083';
}

class MobileJumpButton extends Icon {
  @override
  String draw() => '\ue084';
}

class MobileCrouchButton extends Icon {
  @override
  String draw() => '\ue085';
}

class MobileFlyUpButton extends Icon {
  @override
  String draw() => '\ue086';
}

class MobileFlyDownButton extends Icon {
  @override
  String draw() => '\ue087';
}

class CraftableToggleOn extends Icon {
  @override
  String draw() => '\ue0a0';
}

class CraftableToggleOff extends Icon {
  @override
  String draw() => '\ue0a1';
}

class FoodIcon extends Icon {
  @override
  String draw() => '\ue100';
}

class ArmorIcon extends Icon {
  @override
  String draw() => '\ue101';
}

class Minecoin extends Icon {
  @override
  String draw() => '\ue102';
}

class CodeBuilderButton extends Icon {
  @override
  String draw() => '\ue103';
}

class ImmerseReaderButton extends Icon {
  @override
  String draw() => '\ue104';
}

class Token extends Icon {
  @override
  String draw() => '\ue105';
}

class WinmrLeftGrabButton extends Icon {
  @override
  String draw() => '\ue0c0';
}

class WinmrRightGrabButton extends Icon {
  @override
  String draw() => '\ue0c1';
}

class WinmrMenuButton extends Icon {
  @override
  String draw() => '\ue0c2';
}

class WinmrLeftStickButton extends Icon {
  @override
  String draw() => '\ue0c3';
}

class WinmrRightStickButton extends Icon {
  @override
  String draw() => '\ue0c4';
}

class WinmrLeftTouchpadButton extends Icon {
  @override
  String draw() => '\ue0c5';
}

class WinmrLeftTouchpadHorizontalButton extends Icon {
  @override
  String draw() => '\ue0c6';
}

class WinmrLeftTouchpadVerticalButton extends Icon {
  @override
  String draw() => '\ue0c7';
}

class WinmrRightTouchpadButton extends Icon {
  @override
  String draw() => '\ue0c8';
}

class WinmrRightTouchpadHorizontalButton extends Icon {
  @override
  String draw() => '\ue0c9';
}

class WinmrRightTouchpadVerticalButton extends Icon {
  @override
  String draw() => '\ue0ca';
}

class WinmrLeftTriggerButton extends Icon {
  @override
  String draw() => '\ue0cb';
}

class WinmrRightTriggerButton extends Icon {
  @override
  String draw() => '\ue0cc';
}

class WinmrWindows extends Icon {
  @override
  String draw() => '\ue0cd';
}

class RiftZeroButton extends Icon {
  @override
  String draw() => '\ue0e0';
}

class RiftAButton extends Icon {
  @override
  String draw() => '\ue0e1';
}

class RiftBButton extends Icon {
  @override
  String draw() => '\ue0e2';
}

class RiftLeftGrabButton extends Icon {
  @override
  String draw() => '\ue0e3';
}

class RiftRightGrabButton extends Icon {
  @override
  String draw() => '\ue0e4';
}

class RiftLeftStickButton extends Icon {
  @override
  String draw() => '\ue0e5';
}

class RiftRightStickButton extends Icon {
  @override
  String draw() => '\ue0e6';
}

class RiftLeftTriggerButton extends Icon {
  @override
  String draw() => '\ue0e7';
}

class RiftRightTriggerButton extends Icon {
  @override
  String draw() => '\ue0e8';
}

class RiftXButton extends Icon {
  @override
  String draw() => '\ue0e9';
}

class RiftYButton extends Icon {
  @override
  String draw() => '\ue0ea';
}

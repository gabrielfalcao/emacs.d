import re
import math

# rgb_regex_full = re.compile(r'^([a-f0-9]{2})([a-f0-9]{2})([a-f0-9]{2})$')
# rgb_regex_abbrev = re.compile(r'^([a-f0-9]{1})([a-f0-9]{1})([a-f0-9]{1})$')
rgb_regex = re.compile(r'^([a-f0-9]{1,2})([a-f0-9]{1,2})([a-f0-9]{1,2})$')


class ColorPalette(dict):
    def __init__(self, **kw):
        for key, value in kw.items():


TANGO_PALETTE = {}
TANGO_PALETTE['butter'] = ('fce94f','edd400', 'c4a000')
TANGO_PALETTE['orange'] = ('fcaf3e','f57900', 'ce5c00')
TANGO_PALETTE['chocolate'] = ('e9b96e','c17d11', '8f5902')
TANGO_PALETTE['chameleon'] = ('8ae234','73d216', '4e9a06')
TANGO_PALETTE['sky blue'] = ('729fcf','3465a4', '204a87')
TANGO_PALETTE['plum'] = ('ad7fa8','75507b', '5c3566')
TANGO_PALETTE['scarlet red'] = ('ef2929','cc0000', 'a40000')
TANGO_PALETTE['aluminum light'] = ('eeeeec','d3d7cf', 'babdb6')
TANGO_PALETTE['aluminum dark'] = ('888a85','555753', '2e3436')


for key in [key for key in TANGO_PALETTE.keys() if len(key.split()) > 1]:
    parts = key.split()
    if len(parts) == 1:
        continue
    name = parts[-1]
    TANGO_PALETTE[name] = TANGO_PALETTE[key]


class RgbBands(tuple):
    NAMES = ('red', 'green', 'blue')

    @classmethod
    def from_string(cls, value):
        value = value.lower().strip()
        color = TANGO_PALETTE.get(value, value)
        return RgbBands.from_hex(color)

    @classmethod
    def from_hex(cls, value):
        length = len(value)
        found = length in (3, 6) and rgb_regex.search(value)
        if found:
            return cls(map(lambda c: c.rjust(2, c), found.groups()))

        return cls(RgbBands.DEFAULT)


class ColorRgb:
    def __init__(self, value):
        if isinstance(item, str):
            self.bands = ColorRgb.from_string

class PalleteLuminance:
      LEVELS = ('light', 'medium', 'dark')

      def __init__(self, light, medium, dark):
          self.colors = tuple(zip(PalleteLuminance.LEVELS, map(ColorRgb (light, medium, dark))))

      def __getitem__(self, item):
          if isinstance(item, str):
             for index, level in enumerate(PalleteLuminance.LEVELS):
                 if level == item.lower():
                    return getattr(self.colors, index)
             raise AttributeError(f"invalid luminance {repr(item)}, choices are {', '.join(PalleteLuminance.LEVELS)}")
          elif isinstance(item, int):
              if item != 0:
                  item = math.copysign(item % math.copysign(3, item), item)
              return self.colors[item]
          else:
              raise TypeError(f"item must be either an integer or a string ({', '.join(PalleteLuminance.LEVELS)})")

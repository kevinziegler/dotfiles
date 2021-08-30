"""
Configuration example for ``ptpython``.
Copy this file to $XDG_CONFIG_HOME/ptpython/config.py
On Linux, this is: ~/.config/ptpython/config.py
"""
from prompt_toolkit.filters import ViInsertMode
from prompt_toolkit.key_binding.key_processor import KeyPress
from prompt_toolkit.keys import Keys
from prompt_toolkit.styles import Style

from ptpython.layout import CompletionVisualisation

__all__ = ["configure"]

def configure(repl):
    repl.vi_mode = True
    repl.use_code_colorscheme("solarized-dark")
    repl.color_depth = "DEPTH_24_BIT"
    repl.enable_syntax_highlighting = True

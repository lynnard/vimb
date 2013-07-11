---
title:  Vimb - Frequently asked Questions
layout: default
meta:   FAQ
active: faq
---

# FAQ

## How can I have tabs?

Vimb does not support tabs. Every new page is opened in a new browser instance
with own settings which makes things easier and secure. But vimb can be
plugged into another xembed aware window that allows tabbing like [tabbed][].

    tabbed -c vimb -e

## How to change the colors of the hints?

Vimb hints can be styled by the user style-sheet
(`$XDG_CONFIG_HOME/vimb/style.css`)

This is the default style that is applied to the hints. The `_hintLabel` class
applies to the label with the hint numbers, the `_hintElem` class to the hinted
element (the link, input field or image) and the `_hintFocus` class is added to
the current focused element as well as the label. Following default style is
applied to the hints. To change already defined style it might be required to
use the `!importen` flag on your style definition to take effect
([see also here](#user-scripts)).

    ._hintLabel {
        position: absolute;
        z-index: 100000;
        font-family: monospace;
        font-weight: bold;
        font-size: 10px;
        color: #000;
        background-color: #fff;
        margin: 0;
        padding: 0px 1px;
        border: 1px solid #444;
        opacity: 0.7
    }
    ._hintElem {
        background-color: #ff0 !important;
        color: #000 !important
    }
    ._hintElem._hintFocus{
        background-color: #8f0 !important
    }
    ._hintLabel._hintFocus{
        opacity: 1
    }

## User-Scripts does not seem to have any effect {#user-scripts}

The precedance of the user style is lower than that of the website so you have
to mark your style definition to have higher priority.

    a:link {color: #0f0 !important;}

## How can I use Emacs keybinding for input editing?

If the key theme is installed, following woul do the job for GTK2.

    echo 'gtk-key-theme-name = "Emacs"' >> ~/.gtkrc-2.0

[tabbed]: http://tools.suckless.org/tabbed/
Terminal test page
==================

This is a test of the terminal extension.

Old pattern
-----------

Previously it worked like this:

.. code-block::

    Single command sample:

    .. terminal::
        :input: single command
        :user: root
        :host: vm
        :dir: /tmp/dir/

        output line one
        output line two

    Multiple command sample:

    .. terminal::
        :user: root
        :host: vm
        :dir: /tmp/dir/

        :input: a command
        output line one
        output line two

        :input: another command
        more output

New pattern
-----------

The new pattern separates input from output, and properly supports multi-line input:

.. code-block::

    .. terminal::
        :user: root
        :host: vm
        :dir: /tmp/dir/
        :copy:

        echo 'This is an input line'
        echo 'This is a second input line'

        This is an input line
        This is a second input line

.. terminal::
    :user: root
    :host: vm
    :dir: /tmp/dir/
    :copy:

    echo 'This is an input line' > output.txt
    echo 'This is a second input line'

    This is an input line
    This is a second input line

You can no longer stack multiple commands together. This discourages long samples
with no instruction or written context.
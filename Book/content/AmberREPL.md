Basic moves with the REPL
=========================

    amber repl

Useful keys combos
------------------

    Ctrl-L : clear the screen

    :q     : quits the REPL

Doing useful stuff leveraging node.js abilities
-----------------------------------------------

    fs := require value: 'fs'.
    fs readdir: '/tmp' do: [:anError :aFileName| console log: aFileName].



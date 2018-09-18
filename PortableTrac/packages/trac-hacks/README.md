The trac packages from https://trac-hacks.org
========

fullblogplugin
--------
 * Revision 16270: /fullblogplugin/0.11
    ```shell
    cd fullblogplugin
    svn export https://trac-hacks.org/svn/fullblogplugin/0.11/ . --force
    ```

tagsplugin
--------
 * Revision 16270: /tagsplugin/branches/0.8-stable
    ```shell
    cd tagsplugin
    svn export https://trac-hacks.org/svn/tagsplugin/branches/0.8-stable/ . --force
    ```
 * 此版本可能造成 Wiki 页面保存报错 `no such table: tags_change`， 可以在 “Admin” 中启用 `TracTags` 插件的 `TagSetup` 组件后，通过 `trac-admin /data/tracenv/XXX upgrade` 命令修复;

END
------

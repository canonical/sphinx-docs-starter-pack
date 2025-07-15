rST test file
=============

This file is for testing specific functionality against rST targets.


.. _rst.test.anchor:

``rst.test.anchor``
-------------------

This is an anchor for use in tests for the ``literalref`` role.

``:literalref:`` roles
**********************

* See :literalref:`md.test.anchor`
* See :literalref:`www.google.com`
* See :literalref:`http://localhost:8000`

Versus:

* See :ref:`md.test.anchor`

Terminal extension
------------------

.. terminal::
   :user: starter-pack
   :host: vm
   :dir: Docker/hosting
   :input: docker volume list

   DRIVER    VOLUME NAME
   local     afbce5b0348199a3777259a7495a9a9c1bb98d06c5858aec00df4c2df63bb6b8
   local     community_build-user-builds
   local     community_postgres_backups_data
   local     community_postgres_data_16
   local     community_search_data
   local     community_storage_data

   :input: docker container list
   :input: docker image list

.. terminal::
   :class: no-copybutton
   :user: starter-pack
   :host: vm
   :dir: Docker/hosting
   :input: docker volume list

   DRIVER    VOLUME NAME
   local     afbce5b0348199a3777259a7495a9a9c1bb98d06c5858aec00df4c2df63bb6b8
   local     community_build-user-builds
   local     community_postgres_backups_data
   local     community_postgres_data_16
   local     community_search_data
   local     community_storage_data

   :input: docker container list
   :input: docker image list
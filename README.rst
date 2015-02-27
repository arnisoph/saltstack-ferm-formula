============
ferm-formula
============

Salt Stack Formula to set up and configure ferm, a frontend for ip(6)tables

NOTICE BEFORE YOU USE
=====================

* This formula aims to follow the conventions and recommendations described at http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#conventions-formula and http://docs.saltstack.com/en/latest/topics/best_practices.html

TODO
====

* write states to configure ferm via pillars instead of files

Instructions
============

1. Add this repository as a `GitFS <http://docs.saltstack.com/topics/tutorials/gitfs.html>`_ backend in your Salt master config.

2. Configure your Pillar top file (``/srv/pillar/top.sls``), see pillar.example

3. Include this Formula within another Formula or simply define your needed states within the Salt top file (``/srv/salt/top.sls``).

Available states
================

.. contents::
    :local:

``ferm``
--------
Setup and configure ferm

Additional resources
====================

To let ferm doing it's work when booting the system on RedHat-based systems you can add such a command to ``/etc/rc.d/rc.local``. The `sysvinit-formula <https://github.com/bechtoldt/sysvinit-formula/blob/master/pillar.example.sls#L10>`_ with it.

Templates
=========

Some states/ commands may refer to templates which aren't included in the files folder (``ferm/files``). Take a look at ``contrib/`` (if present) for e.g. template examples and place them in separate file roots (e.g. Git repository, refer to `GitFS <http://docs.saltstack.com/topics/tutorials/gitfs.html>`_) in your Salt master config.

Formula Dependencies
====================

None

Contributions
=============

Contributions are always welcome. All development guidelines you have to know are

* write clean code (proper YAML+Jinja syntax, no trailing whitespaces, no empty lines with whitespaces, LF only)
* set sane default settings
* test your code
* update README.rst doc

Salt Compatibility
==================

Tested with:

* 2014.1.x
* 2014.7.x

OS Compatibility
================

Tested with:

* GNU/ Linux Debian Wheezy
* Centos 6

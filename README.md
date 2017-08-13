abstractit-sudo
====

####Table of Contents

0. [New stuff and bug fixes](#new)
1. [Overview - What is the sudo module?](#overview)
2. [Module Description - What does the module do?](#module-description)
3. [Setup - The basics of getting started with sudo](#setup)
4. [Usage - The parameters available for configuration](#usage)
5. [Implementation - An under-the-hood peek at what the module is doing](#implementation)
6. [Limitations - OS compatibility, etc.](#limitations)
7. [Development - Guide for contributing to the module](#development)
8. [Release Notes - Notes on the most recent updates to the module](#release-notes)

New stuff and bug fixes
-----------------------

I am moving away from using sudo::params as the primary API for the module and moving towards being able to define the classes resource style.
Due to my recent foray into Vagrant, OpenStack and cloud-init I have added support for sudoers.d. It is disabled by default but I will be working towards enabling it for cloud-init and vagrant systems.

I recently started a consulting company called Abstract IT Pty Ltd. I have transfered ownership of all my puppet modules to a new organisation on Puppet Forge called abstractit.
I am making one final release of my modules under rendhalver and abstractit to give you a chance to switch over to the new organisation.
I have also added a licence. All my modules will be licenced under Apache v2.

Overview
--------
Secure extensible sudo management with puppet.

Module Description
------------------

Manages rules, commands, hosts and runas entries in sudo

Setup
-----

**what sudo affects:**

* /etc/sudoers file

### Beginning with sudo

This will manage a basic setup for sudo.

    include sudo

Defaults for vars to set if you need them.
These are class variables so use hiera or and ENC to set them up easily.

Using sudo class

    $sudo::sudoers_dot_d = false
    # Whether to file in include sudoers.d
    $sudo::full_fullaccess_group = $::operatingsystem ? { default => 'wheel', Debian => 'adm', Ubuntu => 'admin' }
    # group of users with full sudo access
    $sudo::extra_full_sudo_users = []
    # array of extra users with full sudo access except shells and su itself
    $sudo::requiretty = false
    # whether you want a tty to exist for sudo ( I leave this unset because my monitoring setup uses sudo for some of it's commands )
    $sudo::extra_path = undef
    # extra path to include before the default
    $sudo::extra_shells = undef
    # extra shells on the node
    $sudo::env_reset = true
    # If the shell environment should be reset on sudo
    $sudo::secure_path = '/sbin:/bin:/usr/sbin:/usr/bin'
    # Force the PATH to be this, set to false to stop setting path

Using sudo::params class variables.
This method will go away soon so please migrate to using sudo variables

    $sudo::params::sudoers_dot_d = false
    # Whether to file in include sudoers.d
    $sudo::params::full_fullaccess_group = $::operatingsystem ? { default => 'wheel', Debian => 'adm', Ubuntu => 'admin' }
    # group of users with full sudo access
    $sudo::params::extra_full_sudo_users = []
    # array of extra users with full sudo access except shells and su itself
    $sudo::params::requiretty = false
    # whether you want a tty to exist for sudo ( I leave this unset because my monitoring setup uses sudo for some of it's commands )
    $sudo::params::extra_path = undef
    # extra path to include before the default
    $sudo::params::extra_shells = undef
    # extra shells on the node
    $sudo::params::env_reset = true
    # If the shell environment should be reset on sudo
    $sudo::params::secure_path = '/sbin:/bin:/usr/sbin:/usr/bin'
    # Force the PATH to be this, set to false to stop setting path

Usage
-----

    sudo::rule { "extra_rule":
      ensure   => present,
      who      => 'bob',
      runas    => 'root', # default runas user is root, please change to override.
      commands => "/usr/sbin/systemctl",
      nopass   => false, #
      setenv   => false,
      comment  => "what ever you like",
    }

### sudo::rule

This type manages extra rules for sudo

**Parameters within sudo::rule**

#### `ensure`

Whether the rule should exist or not (present is the default)

#### `who`

The user running the command

#### `runas`

The user to run commands as (Default is root)

#### `commands`

can also be an array of commands for this rule

#### `nopass`

whether you want the user to supply a password or not  (defaults to false)

#### `setenv`

whether you want to set the SETENV tag  (defaults to false)

#### `comment`

Interted above the rule to explain what it does


    sudo::cmnd { "SYSTEMD":
      ensure => present, # whether the rule should exist or not (present is the default)
      what => '/usr/sbin/systemctl', # can also be an array of commands
      cmnd => "BLAH", # name for these commands
      comment => "what ever you like",
    }

### sudo::cmnd

This type manages extra command sets for sudo

**Parameters within sudo::cmnd**

#### `ensure`

Whether the cmnd set should exist or not (present is the default)

#### `what`

Commands in this set, can be a variable or an array.

#### `cmnd`

Name for this command set

#### `comment`

Interted above the cmnd to explain what it does

    sudo::host { "office":
      ensure => present, # whether the rule should exist or not (present is the default)
      where => 'nagios.example.com', # can also be an array of hosts
      comment => "what ever you like",
    }

### sudo::host

This type manages host groups for sudo

**Parameters within sudo::host**

#### `ensure`

Whether the host group should exist or not (present is the default)

#### `where`

Host or array of hosts in this group

#### `comment`

Description of this host group

    sudo::line { "Icinga-no-tty":
      ensure => present, # whether the rule should exist or not (present is the default)
      line => 'Defaults:icinga !requiretty', # can also be an array of hosts
      comment => "enable access for icinga without requiring tty",
    }

### sudo::line

This type manages pre-formatted lines to be inserted to sudoers

**Parameters within sudo::line**

#### `ensure`

Whether the specific line should exist or not (present is the default)

#### `line`

Optional content of the line to be managed

#### `comment`

Optional description which is inserted befor the line

    sudo::runas { "whoever":
      ensure => present, # whether the rule should exist or not (present is the default)
      who => 'bob', # can also be an array of users
      comment => "what ever you like",
    }

### sudo::runas

This type manages extra runas groups for sudo

**Parameters within sudo::runas**

#### `ensure`

Whether the runas group should exist or not (present is the default)

#### `who`

who this group contains, can be a variable or an array

#### `comment`

Description of this runas group


Implementation
--------------

uses templates and concat to manage the /etc/sudoers file

Limitations
------------

There may be some. Don't hesitate to let me know if you find any.

Development
-----------

All development, testing and releasing is done by me at this stage.
If you wish to join in let me know.

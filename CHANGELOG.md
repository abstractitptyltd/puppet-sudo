##2017-09-12 - Pete Brown <rendhalver@users.noreply.github.com> 1.2.2
###Summary

Ability to insert free-text lines to sudoers #14



##2016-02-11 - Pete Brown <rendhalver@users.noreply.github.com> 1.2.0
###Summary

####Bugfixes

Bugfixes: template variables (@bobtfish and @rfay)
Bugfix: extra_shells wasn't adding a , for path separation (@rendhalver)
Adding support for secure_path and env_reset (@bobtfish)
Adding support for setenv in sudo::rule (@aholen)
Adding support for sudoers.d (@rendhalver)
Allowing an array of commands in sudo::rule
Initial changes to move away from params being the primary API
Adding metadata.json to work with newer versions of puppet module


##2016-01-29 - Pete Brown <rendhalver@users.noreply.github.com> 1.1.3
###Summary

updated documentation for sudo::rule
fixed mode for /etc/sudoers file to stop constant changes

####Bugfixes

##2016-01-29 - Pete Brown <rendhalver@users.noreply.github.com> 1.1.2
###Summary

moved `sudo_fullaccess_group` into class vars for sudo::params
include sudo in sudo::register class to make sure it gets loaded

####Bugfixes

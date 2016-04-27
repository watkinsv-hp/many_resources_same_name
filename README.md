# many_resources_same_name

Demonstrate a potential issue we found with chefspec where it appears chefspec is evaluating the current example against the last resource of the same name found in the recipe.

```
Failures:

  1) many_resources_same_name::default When all attributes are default, on an unspecified platform creates a rabbitmq user
     Failure/Error:
       expect(chef_run).to add_rabbitmq_user('jackdaniels')
       .with(password: 'the.secret.is.in.the.barrel')
     
       expected "rabbitmq_user[jackdaniels]" actions [:set_permissions] to include :add
     # ./spec/unit/recipes/default_spec.rb:31:in `block (3 levels) in <top (required)>'

  2) many_resources_same_name::default When all attributes are default, on an unspecified platform sets the tag on a rabbitmq user
     Failure/Error:
       expect(chef_run).to set_tags_rabbitmq_user('jackdaniels')
       .with(tag: 'administrator')
     
       expected "rabbitmq_user[jackdaniels]" actions [:set_permissions] to include :set_tags
     # ./spec/unit/recipes/default_spec.rb:36:in `block (3 levels) in <top (required)>'

Finished in 30.34 seconds (files took 7.31 seconds to load)
4 examples, 2 failures

Failed examples:

rspec ./spec/unit/recipes/default_spec.rb:30 # many_resources_same_name::default When all attributes are default, on an unspecified platform creates a rabbitmq user
rspec ./spec/unit/recipes/default_spec.rb:35 # many_resources_same_name::default When all attributes are default, on an unspecified platform sets the tag on a rabbitmq user

watkinsv@watkinsv-HP-EliteBook-8560w:~/src/cookbooks/many_resources_same_name$ dpkg -l chefdk
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
|/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
||/ Name                                Version                Architecture           Description
+++-===================================-======================-======================-===========================================================================
ii  chefdk                              0.10.0-1               amd64                  The full stack of chefdk
watkinsv@watkinsv-HP-EliteBook-8560w:~/src/cookbooks/many_resources_same_name$ gem list chefspec

*** LOCAL GEMS ***

chefspec (4.5.0, 4.4.0)
watkinsv@watkinsv-HP-EliteBook-8560w:~/src/cookbooks/many_resources_same_name$ which gem
/opt/chefdk/embedded/bin/gem
watkinsv@watkinsv-HP-EliteBook-8560w:~/src/cookbooks/many_resources_same_name$ cat /etc/issue
Ubuntu 14.04.4 LTS \n \l
watkinsv@watkinsv-HP-EliteBook-8560w:~/src/cookbooks/many_resources_same_name$ 
```

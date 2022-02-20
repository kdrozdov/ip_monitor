## Documentation

Deployment:
See [stand-alone document](https://www.notion.so/amarkets/Technical-documents-3f7a5405592a4f318a5064dbd6668541)

#### Seed version
0.1.0

When version of _Seed project_ will be changed, developer can compare _Seed version_ of _his project_ with the latest version of _Seed project_, and add to his project differences between them using `git diff` or other way

Please update version of this section when updataing your project to new Seed version

#### Hosts

Staging:
[https://processing.amarkets.com](https://trans.k8sdev.amarkets.com)


## Usage

#### Requirements:
* postgresql
* ruby 2.7.3

#### Local installation (prepare)

Create new database user with superuser role. Assign a password to new role (password: ruby):
```
createuser -dlsP ruby
```

#### Local installation
Install gems:

```bash
bundle install

rake db:create
INSTANCE=test rake db:create # or APP_ENV=test

rake db:migrate
INSTANCE=test rake db:migrate # or APP_ENV=test
```

#### Rake tasks

Start server at development mode:
```
rake app:server
```

Run pry console
```
rake app:console
```
## Zeitwerk error

After using ```rake db:create``` you may get:

```Sequel::DatabaseConnectionError: PG::ConnectionBad: FATAL:  database "ninja_PROJECT_NAME_development" does not exist```

That's because of Zeitwerk preloading files including sequel.rb with ```Sequel.connect(CONFIG.db).tap do```

Solution: comment out strings ```loader.preload ...``` in ```boot.rb``` and use ```rake db:create``` again

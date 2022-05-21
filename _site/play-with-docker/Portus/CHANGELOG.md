## Upcoming Version

### Improvements and small features

- Update the development environment for docker-compose v2.
- Fixed icon incoherent in teams page on add namespace action button

## 2.2.0

### Fixes

- Portus will now properly update the image ID when a tag has been pushed. See PR [#1054](https://github.com/SUSE/Portus/pull/1054).
- Fixed how image updates are handled. See PR [#1031](https://github.com/SUSE/Portus/pull/1031).
- Follow a consistent order in the signup form. See PR [#1119](https://github.com/SUSE/Portus/pull/1119).
- Hide passwords stored in webhooks. See PR [#1111](https://github.com/SUSE/Portus/pull/1111).
- Removed reference of missing stylesheets. See PR [#1114](https://github.com/SUSE/Portus/pull/1114).
- Fixed a bunch of issues related to activities. See PR [#1144](https://github.com/SUSE/Portus/pull/1144).
- Fixed the pre-compilation of the cover.js asset. See PR [#1157](https://github.com/SUSE/Portus/pull/1157).

### Features

- portusctl: it will show a warning when using the `--local-registry` flag but the package has not been installed. See PR [#1096](https://github.com/SUSE/Portus/pull/1096).
- Portus now supports Docker Distribution 2.5. See PR [#1068](https://github.com/SUSE/Portus/pull/1068).
- Allow docker-compose users to specify an alternative port. See PR [#1094](https://github.com/SUSE/Portus/pull/1094).

### Documentation

- Avoid the confusion on the hostnames to be used. See PR [#1056](https://github.com/SUSE/Portus/pull/1056).
- Clarified how the `--local-registry` flag works. PR [#1052](https://github.com/SUSE/Portus/pull/1052).

## 2.1.1

### Fixes

- Use the full repository name in the `portus:update_tags` task (see [005ec6503208](https://github.com/SUSE/Portus/commit/005ec6503208fa306703f55e0c8564abe12a94a2))
- Fixed a regression on assets handling (see [fc6982a4bfe2](https://github.com/SUSE/Portus/commit/fc6982a4bfe2400a00176e0981fbd112d9f9b434) and [fdb92fffb5fa](https://github.com/SUSE/Portus/commit/fdb92fffb5fa60dbef8a4dbc8e0e30732816ae58))
- Fixed the handling of the "*" action from the registry (see [6afb1ac150e6](https://github.com/SUSE/Portus/commit/6afb1ac150e6a0e3cea2cf6c03ec077ab2d59ca3))

### Improvements

- Notification messages are now more consistent (see [72e452b1fd20](https://github.com/SUSE/Portus/commit/72e452b1fd20fa1d3072a1c6fda04077e57dfcb9))
- Order users by username on the admin panel (see [e92106cd951b](https://github.com/SUSE/Portus/commit/e92106cd951b877df0b7b83fa4241b5afb4eb175))

## 2.1

### Featured

- Fixes and improvements on Docker Distribution support (see [f74eb2eac7d6](https://github.com/SUSE/Portus/commit/f74eb2eac7d6), [c8fc5ed6b337](https://github.com/SUSE/Portus/commit/c8fc5ed6b337), [95ba4d83a539](https://github.com/SUSE/Portus/commit/95ba4d83a539), [552df9caa341](https://github.com/SUSE/Portus/commit/552df9caa341), [575d51b3b7d2](https://github.com/SUSE/Portus/commit/575d51b3b7d2), [4014a7c14487](https://github.com/SUSE/Portus/commit/4014a7c14487), [e18310e6a2eb](https://github.com/SUSE/Portus/commit/e18310e6a2eb) and [7494eeed2b88](https://github.com/SUSE/Portus/commit/7494eeed2b88))
- Implemented user removal (see [d9d6e3afa224](https://github.com/SUSE/Portus/commit/d9d6e3afa224))
- Implemented the removal of images and tags (see [b63252ff07a8](https://github.com/SUSE/Portus/commit/b63252ff07a8), [10c060e246ab](https://github.com/SUSE/Portus/commit/10c060e246ab), [7ae5179ba623](https://github.com/SUSE/Portus/commit/7ae5179ba623), [85730266c9c4](https://github.com/SUSE/Portus/commit/85730266c9c4), [65a0624cd923](https://github.com/SUSE/Portus/commit/65a0624cd923), [612734339fa1](https://github.com/SUSE/Portus/commit/612734339fa1) and [c23758489c57](https://github.com/SUSE/Portus/commit/c23758489c57))
  - Also read our [blog post on image/tag removal](http://port.us.org/2016/06/20/removing-images-and-tags.html)
- Showing the image ID and the digest of docker images (see [0f290526ad97](https://github.com/SUSE/Portus/commit/0f290526ad97), [960e7599d501](https://github.com/SUSE/Portus/commit/960e7599d501), [28dae7f3fb23](https://github.com/SUSE/Portus/commit/28dae7f3fb23), [ba32d140958a](https://github.com/SUSE/Portus/commit/ba32d140958a), [0b8d1bff5b85](https://github.com/SUSE/Portus/commit/0b8d1bff5b85) and [e57232b149b5](https://github.com/SUSE/Portus/commit/e57232b149b5))
- Implemented webhook support (see [4a4a67c62d52](https://github.com/SUSE/Portus/commit/4a4a67c62d52), [702356b006d8](https://github.com/SUSE/Portus/commit/702356b006d8), [60354bb41ddc](https://github.com/SUSE/Portus/commit/60354bb41ddc), [08918c5a91d2](https://github.com/SUSE/Portus/commit/08918c5a91d2), [4b4d4c0ff70e](https://github.com/SUSE/Portus/commit/4b4d4c0ff70e) and [b3565d3ade0f](https://github.com/SUSE/Portus/commit/b3565d3ade0f))
  - Also read our [blog post on webhooks](http://port.us.org/2016/07/26/webhooks.html)
- Introduce application tokens (see [b399f90c0de5](https://github.com/SUSE/Portus/commit/b399f90c0de5) and [e38e7602f471](https://github.com/SUSE/Portus/commit/e38e7602f471))

### Improvements and small features

- Better reflect updates on Docker images (see [89b9964c0f0e](https://github.com/SUSE/Portus/commit/89b9964c0f0e))
- General improvements and fixes on the UI/UX (see [cb033f40898e](https://github.com/SUSE/Portus/commit/cb033f40898e), [e7629b758055](https://github.com/SUSE/Portus/commit/e7629b758055), [fcfd6d3548aa](https://github.com/SUSE/Portus/commit/fcfd6d3548aa), [933b86fbe9bf](https://github.com/SUSE/Portus/commit/933b86fbe9bf), [c886e9009ee0](https://github.com/SUSE/Portus/commit/c886e9009ee0), [818354d7d92c](https://github.com/SUSE/Portus/commit/818354d7d92c), [868abc65d286](https://github.com/SUSE/Portus/commit/868abc65d286), [f935d0ae79a5](https://github.com/SUSE/Portus/commit/f935d0ae79a5), [128c76febb06](https://github.com/SUSE/Portus/commit/128c76febb06), [23da71c64c7c](https://github.com/SUSE/Portus/commit/23da71c64c7c), [1ef1da2e9c70](https://github.com/SUSE/Portus/commit/1ef1da2e9c70), [78a9d81965fa](https://github.com/SUSE/Portus/commit/78a9d81965fa), [a3ffe492d134](https://github.com/SUSE/Portus/commit/a3ffe492d134))
- Allow the admin to provide extra filter options in LDAP lookup (see [99daa00d565b](https://github.com/SUSE/Portus/commit/99daa00d565b))
- Password length is no longer checked by Portus in LDAP (see [381fd61fb546](https://github.com/SUSE/Portus/commit/381fd61fb546))
- Relaxed the requirements for user names, and removed the conflicts of user names in LDAP (see [a9d5a2646d0d](https://github.com/SUSE/Portus/commit/a9d5a2646d0d) and [215c681e65c2](https://github.com/SUSE/Portus/commit/215c681e65c2))
- Introduce the `display_name` option (see [5d8c7e4bec97](https://github.com/SUSE/Portus/commit/5d8c7e4bec97))
- Allow administrators to turn off smtp authentication (see [d837160bbe3e](https://github.com/SUSE/Portus/commit/d837160bbe3e))
- Added an external hostname field to allow for events to come from other named services (see [0d58ed1fce0b](https://github.com/SUSE/Portus/commit/0d58ed1fce0b))
- Added a help section to the menu (see [40a18a04b1fe](https://github.com/SUSE/Portus/commit/40a18a04b1fe))
- Introduced more optional user restrictions (see [cddfb5924fae](https://github.com/SUSE/Portus/commit/cddfb5924fae))
- Added the registry.catalog_page option (see [de4e4f4db74e](https://github.com/SUSE/Portus/commit/de4e4f4db74e))
- Added option to disable change of visibility (see [50fb319ded81](https://github.com/SUSE/Portus/commit/50fb319ded81))
- The signup form can now be disabled, and users can be created by the admin directly (see [9bbd75cacd935f888460669d77fa47c706a5dbaf](https://github.com/SUSE/Portus/commit/9bbd75cacd935f888460669d77fa47c706a5dbaf), [79bac5c4f54b758831c867fc08b0b567418cae7d](https://github.com/SUSE/Portus/commit/79bac5c4f54b758831c867fc08b0b567418cae7d) and [fcf20d7534e2f1172713f82e06ef12abe14df046](https://github.com/SUSE/Portus/commit/fcf20d7534e2f1172713f82e06ef12abe14df046))
- Added internal policy for namespaces (see [46d1d0bc7251](https://github.com/SUSE/Portus/commit/46d1d0bc7251))
- Added namespaces and teams to search (see [f1a9698657c8](https://github.com/SUSE/Portus/commit/f1a9698657c8))
- Admins can now change the ownership of a namespace (see [e4b137a92a96](https://github.com/SUSE/Portus/commit/e4b137a92a96))
- Display the git tag, branch/commit or version when possible (see [a7bfa8dde140](https://github.com/SUSE/Portus/commit/a7bfa8dde140))
- Now logs are redirected to the standard output (see [dfc72b3d6abd](https://github.com/SUSE/Portus/commit/dfc72b3d6abd))
- Added the ability to add comments on repositories (see [4d780d93950b](https://github.com/SUSE/Portus/commit/4d780d93950b))
- Virtual/hidden teams are no longer counted for the  "number of teams"-column under admin/users (see [02722126cb92](https://github.com/SUSE/Portus/commit/02722126cb92))
- Added rake tasks for creating a registry, updating digests and showing general information (see [ec0d0063b781](https://github.com/SUSE/Portus/commit/ec0d0063b781), [4566ea0607fd](https://github.com/SUSE/Portus/commit/4566ea0607fd) and [152ce27725f7](https://github.com/SUSE/Portus/commit/152ce27725f7))
- Added man pages for portusctl ([8b4b31e1cfc3](https://github.com/SUSE/Portus/commit/8b4b31e1cfc3))
- Register more activities (see [fd97edaf6bb6](https://github.com/SUSE/Portus/commit/fd97edaf6bb6) and [bee150287604](https://github.com/SUSE/Portus/commit/bee150287604))

### Fixes

- Various fixes in LDAP support (see [b13dca7e207f](https://github.com/SUSE/Portus/commit/b13dca7e207f), [7e3feabcc2bb](https://github.com/SUSE/Portus/commit/7e3feabcc2bb) and [377a59b66c16](https://github.com/SUSE/Portus/commit/377a59b66c16))
- Discard pagination for CSV activities (see [7f120349279f](https://github.com/SUSE/Portus/commit/7f120349279f))
- Make sure that Portus admins are always team owners (see [2db13a3ae524](https://github.com/SUSE/Portus/commit/2db13a3ae524))
- User names are no longer allowed to clash with teams (see [b5b0896e78b3](https://github.com/SUSE/Portus/commit/b5b0896e78b3))
- Redirect back to accessed page on successful login (see [fed27a5dcf6a](https://github.com/SUSE/Portus/commit/fed27a5dcf6a))
- Fixes on the crono job (see [efc33be00d2e](https://github.com/SUSE/Portus/commit/efc33be00d2e) and [08d60dd91a5e](https://github.com/SUSE/Portus/commit/08d60dd91a5e))
- Multiple fixes in portusctl (see [46b5f449263f](https://github.com/SUSE/Portus/commit/46b5f449263f), [add79d790238](https://github.com/SUSE/Portus/commit/add79d790238), [2025da82f3e5](https://github.com/SUSE/Portus/commit/2025da82f3e5), [aa4997ab48a4](https://github.com/SUSE/Portus/commit/aa4997ab48a4), [f8d473430ee1](https://github.com/SUSE/Portus/commit/f8d473430ee1), [5d4eb85943ff](https://github.com/SUSE/Portus/commit/5d4eb85943ff) and [78f8f949c46e](https://github.com/SUSE/Portus/commit/78f8f949c46e))
- Multiple fixes in our RPM (see [919452db8507](https://github.com/SUSE/Portus/commit/919452db8507), [0019a65cad3b](https://github.com/SUSE/Portus/commit/0019a65cad3b), [0be925085b30](https://github.com/SUSE/Portus/commit/0be925085b30), [050d095b0887](https://github.com/SUSE/Portus/commit/050d095b0887) and [3f56c4ae4f6d](https://github.com/SUSE/Portus/commit/3f56c4ae4f6d))
- Show the "I forgot my password" link when the signup is disabled (see [2a244c8160d0](https://github.com/SUSE/Portus/commit/2a244c8160d0))

### Breaking changes

- Moved the machine FQDN from secrets.yml to config.yml (see [984671662ade](https://github.com/SUSE/Portus/commit/984671662ade))
- Deprecated the usage of "x.minutes" strings in configuration values. In future
  versions this syntax will be forbidden (see [53400181e439](https://github.com/SUSE/Portus/commit/53400181e439))

### Others

- All the improvements, features and bug fixes mentioned in the notes of 2.0.x releases.

## 2.0.5

### Improvements

- The FQDN can now be specified from the configuration too. This is meant to
  help users to transition from 2.0.x to 2.1. See
  [commit](https://github.com/SUSE/Portus/commit/f0850459cc43e9b9258e70867d5608f2ef303f3e).
- Portus is now more explicit on the allowed name format. See
[commit](https://github.com/SUSE/Portus/commit/5e1f164bacca8119fd6f9d8ec0461281914a0ecd).
- Portus is now more friendly on errors based on the namespace name. See
[commit](https://github.com/SUSE/Portus/commit/2cc3ea0803632c13ba49022f369d74dbb4e549c9).

### portusctl

- Disable automatic generation of certificates. For this, now there are two new
  flags: `--ssl-gen-self-signed-certs` and `--ssl-certs-dir <dir>`. See
  [commit](https://github.com/SUSE/Portus/commit/d34714f9a43024b1b565699bbcef22d51ea3a4f2).
- Wrap crono with the `exec` command. See
[commit](https://github.com/SUSE/Portus/commit/78f8f949c46e6cf41f058237683e2d8f5795e53e).

### Misc

- Some fixes on the generation of the RPM in OBS.

## 2.0.4

### RPM

- Automate Portus release. See [commit](https://github.com/SUSE/Portus/commit/63ce12464f54a1d2ffeb427850e20595b26bc52f).
- Rename Portus to portus on the RPM. See [commit](https://github.com/SUSE/Portus/commit/648d96c39ec6c10926b652579cf3a4c9ade69781).
- Refactored RPM. See [commit](https://github.com/SUSE/Portus/commit/378c66e0119a34a03adbc60cc489a19f9e77f4dd).
- Wrap crono with the exec command in the RPM. See [commit](https://github.com/SUSE/Portus/commit/78f8f949c46e6cf41f058237683e2d8f5795e53e).
- Require net-tools on the RPM. See [commit](https://github.com/SUSE/Portus/commit/919452db850709932bbf9e7f06a8dcdc83def931).

### portusctl

- Use the proper `make_admin` task. See [commit](https://github.com/SUSE/Portus/commit/aa4997ab48a4a15e9182ce6c48e9521501b81c97).
- Don't configure mysql in Docker. See [commit](https://github.com/SUSE/Portus/commit/2025da82f3e5550672b09e249c3cfd9a924aa64d).
- Added the portus:info task. See [commit](https://github.com/SUSE/Portus/commit/152ce27725f7896cad2dc024d29f9b33ab0fc83a).

### Improvements

- Better Sub-URI handling & configurable config-local.yml path. See [PR](https://github.com/SUSE/Portus/pull/851).
- Update ruby versions on travis. See [commit1](https://github.com/SUSE/Portus/commit/f1f34056863186d649a8412916ce33de0ac6dd78) and [commit2](https://github.com/SUSE/Portus/commit/0b34c0c56dd3458cc4cce6afba354f9659efd2ee).

### Other fixes

- Logout button and search repository are now appearing in small devices. See [commit](https://github.com/SUSE/Portus/commit/9dd5149a2561d62266124f36ab2404817aa826d5).
- Don't allow access to the hidden global team. See [commit](https://github.com/SUSE/Portus/commit/a540fd545d59bf72ef3a073d28617c87d978d44d).

## 2.0.3

- Fixed crono job when a repository could not be found. See [commit](https://github.com/SUSE/Portus/commit/120301caf665f7b637cd7ced7282461436dc1eb7).
- Fixed more issues on docker 1.10 and distribution 2.3. See
[this](https://github.com/SUSE/Portus/commit/841dbd274ed5e7efcb68105f0de13ac2954234dc)
and [this](https://github.com/SUSE/Portus/commit/75d61c6d692ebe6086ce1a16b0899fbcd8916a6e)
commits.
- Handle multiple scopes in token requests. See [commit](https://github.com/SUSE/Portus/commit/87623975690e693c8df1901ce7b255d41b530e5e).
- Add optional fields to token response. See [commit](https://github.com/SUSE/Portus/commit/f6e6e841217e9e543fcaa7af196ce5e5009ab28d).

## 2.0.2

- Fixed notification events for distribution v2.3. See [commit](https://github.com/SUSE/Portus/commit/3817d09108907fa26ddaf5ce23291a326b8b8195).

## 2.0.1

- Paginate through the catalog properly. See [commit](https://github.com/SUSE/Portus/commit/6e31712c6669df569f24daba4020f5d6607ad7db).
- Do not remove all the repos if fetching one fails. See [commit](https://github.com/SUSE/Portus/commit/5626ad9802c663718a3a31675c8383e94e9a10c3).
- Fixed SMTP setup. See [commit](https://github.com/SUSE/Portus/commit/296dabe3dd1c236409aaa31f19fb6e4a2e003c25).
- Don't let crono overflow the `log` column on the DB. See [commit](https://github.com/SUSE/Portus/commit/a0ed6d68c328fe6a9cd5e57506ba1773a96189da).
- Show the actual LDAP error on invalid login. See [commit](https://github.com/SUSE/Portus/commit/260eace6ea7a360a040e230cb9c1c72afcb1abab).
- Fixed the location of crono logs. See [commit](https://github.com/SUSE/Portus/commit/1bd45d8796def0256a1dd84a74a5b3fb4e9b702a).
- Always use relative paths. See [commit](https://github.com/SUSE/Portus/commit/93259fc7affd38f833685f565c0af1bb4d46c876).
- Set RUBYLIB when using portusctl. See [commit](https://github.com/SUSE/Portus/commit/3fdce03646386074a0982d3d642155526dea7753).
- Don't count hidden teams on the admin panel. See [commit](https://github.com/SUSE/Portus/commit/8f57252bb9118016d1098c0936fb69a708dc4d54).
- Warn developers on unsupported docker-compose versions. See [commit](https://github.com/SUSE/Portus/commit/02605b3c3eef72a4a78d8db7fda05df2eae2e7db).
- Directly invalidate LDAP logins without name and password. See [commit](https://github.com/SUSE/Portus/commit/0c0c5a1be243bd42873cb852ebb7b189df16b6fa).
- Don't show the "I forgot my password" link on LDAP. See [commit](https://github.com/SUSE/Portus/commit/1daaf1117e8d83b425373cfae45892e519fd20fa).
- Small random fixes:
  - [9f25126bd4409acf197a24b220cabc23efd7fb80](https://github.com/SUSE/Portus/commit/9f25126bd4409acf197a24b220cabc23efd7fb80)
  - [0b5c50244d02440008bd8c0cdd9094af66d9d1d9](https://github.com/SUSE/Portus/commit/0b5c50244d02440008bd8c0cdd9094af66d9d1d9)

## 2.0.0

- Portus will now check whether a Registry is reachable or not.
See PR [#437](https://github.com/SUSE/Portus/pull/437).
- Namespaces and teams have a description field. See PR
[#383](https://github.com/SUSE/Portus/pull/383).
- Second UI iteration. See pull requests:
[#445](https://github.com/SUSE/Portus/pull/445),
[#447](https://github.com/SUSE/Portus/pull/477) and
[#462](https://github.com/SUSE/Portus/pull/462).
- Repositories contained in *public* namespaces are now pullable even for
non-logged in users: PR [#468](https://github.com/SUSE/Portus/pull/468).
- SUSE RPM: provide `portusctl` tool to simplify the initial setup of Portus
- Portus will now lock users' accounts that have failed too many times on
login. See PR [#330](https://github.com/SUSE/Portus/pull/330).
- Added a mechanism of password recovery in case users forget about their
password. See PR [#325](https://github.com/SUSE/Portus/pull/325).
- Set admin user from a rake task and disable first-user is admin. See PR [#314]
  (https://github.com/SUSE/Portus/pull/314)
- Added a configuration option to specify the expiration time for JWT tokens
issued by Portus. See PR [518](https://github.com/SUSE/Portus/pull/518).
- Review requirements and provides in the RPM
PR [#277](https://github.com/SUSE/Portus/pull/277),
PR [#278](https://github.com/SUSE/Portus/pull/278),
PR [#280](https://github.com/SUSE/Portus/pull/280),
PR [#273](https://github.com/SUSE/Portus/pull/273),
- Add configure scripts for the RPM and use environment variables for
production. See:
PR [#299](https://github.com/SUSE/Portus/pull/299),
PR [#298](https://github.com/SUSE/Portus/pull/298),
PR [#281](https://github.com/SUSE/Portus/pull/281)
- Check run time requirements like ssl, secrets. See
PR [#297](https://github.com/SUSE/Portus/pull/297),
PR [#286](https://github.com/SUSE/Portus/pull/286)
- Update uglifier gem for fixing a security issue (OSVDB-126747)
PR [#292](https://github.com/SUSE/Portus/pull/292)
- Introduced LDAP support. See the initial PR [#301](https://github.com/SUSE/Portus/pull/301).
Multiple PRs followed to bring LDAP support to a proper state (see
[this](https://github.com/SUSE/Portus/pulls?utf8=%E2%9C%93&q=is%3Apr+is%3Aclosed+LDAP+created%3A%3C%3D2015-10-26+)).
- Users will not be able to create namespaces without a Registry currently
existing.
- PhantomJS is now being used in the testing infrastructure. See the following
pull requests: [#193](https://github.com/SUSE/Portus/pull/193),
[#194](https://github.com/SUSE/Portus/pull/194),
[#213](https://github.com/SUSE/Portus/pull/213),
[#216](https://github.com/SUSE/Portus/pull/216),
[#219](https://github.com/SUSE/Portus/pull/219).
- The namespace page now shows the creation date. See PR
[#229](https://github.com/SUSE/Portus/pull/229).
- There have been some fixes on the search feature. See
[#223](https://github.com/SUSE/Portus/pull/223) and
[#224](https://github.com/SUSE/Portus/pull/224).
- Hidden teams are no longer able to create namespaces. See PR
[#220](https://github.com/SUSE/Portus/pull/220).
- Added the pagination feature. See PR [#232](https://github.com/SUSE/Portus/pull/232).
- Some initial steps have been done towards running Portus inside docker. See
PR [#212](https://github.com/SUSE/Portus/pull/212).
- Added the appliance tests. See PR [#208](https://github.com/SUSE/Portus/pull/208).
- Star/Unstar repositories. See PR [#230](https://github.com/SUSE/Portus/pull/230)
and [#294](https://github.com/SUSE/Portus/pull/294).
- Now users can be enabled/disabled. See PR [#240](https://github.com/SUSE/Portus/pull/240).
- Fixed the authentication process for Docker 1.8. See PR
[#282](https://github.com/SUSE/Portus/pull/282).
- Added icons to the following tables: teams and members. See PR
[#388](https://github.com/SUSE/Portus/pull/388).
- And some fixes here and there.

## 1.0.1

- Fixed regression where namespaces could not be created from team page
    (Fixes #165)

## 1.0.0

- Initial version

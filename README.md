# Messenger No Ads

[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE)

Tweak to remove ads on Messenger & Messenger Lite app for iOS!

Just install, no preferences. Require device jailbroken

## Cydia Repo

[https://haoict.github.io/cydia](https://haoict.github.io/cydia)

## Building

[Theos](https://github.com/theos/theos) required.

```bash
make do
```

## [Note] Advanced thingy for development

Add your device IP in `~/.bash_profile` or in project's `Makefile` for faster deployment
```
THEOS_DEVICE_IP = 192.168.1.21
```

Add SSH key for target deploy device so you don't have to enter ssh root password every time
```bash
cat ~/.ssh/id_rsa.pub | ssh -p 22 root@192.168.1.21 "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
```

Build the final package
```bash
FINALPACKAGE=1 make package
```

## Contributors

[haoict](https://github.com/haoict)

Contributions of any kind welcome!

## License

Licensed under the MIT License, Copyright © 2020-present Hao Nguyen <hao.ict56@gmail.com>

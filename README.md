# "e.g."
Tool to save commands for future reference.
## Quickstart
```
$ e.g. -h
"Tool to save commands for future reference."
Usage: e.g. <subcommand> [options]
Where subcommand is one of: add, show, list
To get further help on the subcommands, use the -h option with the subcommand.

$ e.g. add -m 'Create a 10Kb file with random data.' dd if=/dev/urandom of=/tmp/file.out bs=1024 count=10
dd if=/dev/urandom of=/tmp/file.out bs=1024 count=10 # Create a 10Kb file with random data.

$ e.g. add -m 'Create an ISO image' dd if=/dev/disk1 of=Image.iso
dd if=/dev/disk1 of=Image.iso # Create an ISO image

$ e.g. show dd
dd if=/dev/urandom of=/tmp/file.out bs=1024 count=10 # Create a 10Kb file with random data.
dd if=/dev/disk1 of=Image.iso # Create an ISO image
```

## Under the covers
```
$ e.g. add -m 'Create a 10Kb file with random data.' dd if=/dev/urandom of=/tmp/file.out bs=1024 count=10
dd if=/dev/urandom of=/tmp/file.out bs=1024 count=10 # Create a 10Kb file with random data.

$ e.g. add -m 'Create an ISO image' dd if=/dev/disk1 of=Image.iso
dd if=/dev/disk1 of=Image.iso # Create an ISO image

$ ls -l ~/.e.g./
-rw-r--r--  1 myuser  mygroup   144 Sep 16 22:04 dd

$ cat ~/.e.g./dd
dd if=/dev/urandom of=/tmp/file.out bs=1024 count=10 # Create a 10Kb file with random data.
dd if=/dev/disk1 of=Image.iso # Create an ISO image
```

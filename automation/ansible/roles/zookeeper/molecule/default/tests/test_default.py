import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_package(host):
    if host.system_info.distribution == 'centos':
        d = host.file("/opt/zookeeper-3.4.13")
        assert d.exists
        assert d.is_directory
        assert d.user == 'zookeeper'
        assert d.group == 'zookeeper'
    else:
        pkg = ["zookeeperd"]
        assert host.package(pkg).is_installed


def test_data_directory(host):
    d = host.file("/data/zookeeper")
    assert d.exists
    assert d.is_directory
    assert d.user == 'zookeeper'
    assert d.group == 'zookeeper'


def test_log_directory(host):
    d = host.file("/var/log/zookeeper")
    assert d.exists
    assert d.is_directory
    assert d.user == 'zookeeper'
    assert d.group == 'zookeeper'


def test_myid_file(host):
    f = host.file("/etc/zookeeper/conf/myid")
    assert f.exists
    assert f.is_file
    assert f.user == 'zookeeper'
    assert f.group == 'zookeeper'


def test_config_file(host):
    f = host.file("/etc/zookeeper/conf/zoo.cfg")
    assert f.exists
    assert f.is_file
    assert f.user == 'zookeeper'
    assert f.group == 'zookeeper'

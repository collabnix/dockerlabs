import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_package(host):
    pkg = ["marathon"]
    assert host.package(pkg).is_installed


def test_config_file(host):
    f = host.file("/etc/defaults/marathon")
    assert f.exists
    assert f.is_file
    assert f.user == 'root'
    assert f.group == 'root'

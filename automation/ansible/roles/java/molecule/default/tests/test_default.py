import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_package(host):
    if host.system_info.distribution == 'centos':
        pkg = ["java-1.8.0-openjdk"]
    else:
        pkg = ["default-jdk"]

    assert host.package(pkg).is_installed

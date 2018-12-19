import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_epel_repository(host):
    f = host.file("/etc/yum.repos.d/epel-repository.repo")
    assert f.exists
    assert f.user == 'root'
    assert f.group == 'root'

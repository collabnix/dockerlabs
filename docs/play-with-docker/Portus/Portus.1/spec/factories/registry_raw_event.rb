require_relative "../support/models/registry_raw_event"

# Docker Registry v2: Push Notifications
# https://docs.docker.com/registry/notifications/#events
FactoryGirl.define do
  factory :raw_push_manifest_event, class: RegistryRawEvent do
    action "push"
    target(
      "digest"     => "sha256:0123456789abcdef0",
      "repository" => "foo/busybox",
      "url"        => "http://registry.test.lan/v2/foo/manifests/latest"
    )
    request("host" => "registry.test.lan")
    actor("name" => "flavio")
  end

  factory :raw_push_layer_event, class: RegistryRawEvent do
    action "push"
    target(
      "digest"     => "sha256:0123456789abcdef0",
      "repository" => "foo/busybox",
      "url"        => "http://registry.test.lan/v2/foo/layer/123"
    )
    request("host" => "registry.test.lan")
    actor("name" => "flavio")
  end

  factory :raw_pull_event, class: RegistryRawEvent do
    action "pull"
    target(
      "digest"     => "sha256:0123456789abcdef0",
      "repository" => "foo/busybox",
      "url"        => "http://registry.test.lan/v2/foo/manifests/latest"
    )
    request("host" => "registry.test.lan")
    actor("name" => "flavio")
  end
end

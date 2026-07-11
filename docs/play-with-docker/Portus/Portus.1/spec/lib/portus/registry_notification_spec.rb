require "rails_helper"

describe Portus::RegistryNotification do
  let(:body) do
    {
      "events" => [
        { "action" => "push" },
        { "action" => "push", "target" => { "mediaType" => "some" } },
        {
          "action" => "pull", "target" => {
            "mediaType" => "application/vnd.docker.distribution.manifest.v1+json"
          }
        }
      ]
    }
  end

  let(:relevant) do
    {
      "action" => "push",
      "target" => {
        "mediaType"  => "application/vnd.docker.distribution.manifest.v1+json",
        "digest"     => "sha256:1977980aad73e19f918c676de1860b0ee56167b07c20641ecda3f9d74b69627d",
        "repository" => "mssola/busybox",
        "url"        => "http://registry.test.lan/v2/mssola/busybox/manifests/sha256:1977980aad7"
      }
    }
  end

  let(:delete) do
    {
      "id"        => "6d673710-06b5-48b5-a7d9-94cbaacf776b",
      "timestamp" => "2016-04-13T15:03:39.595901492+02:00",
      "action"    => "delete",
      "target"    => {
        "digest"     => "sha256:03d564cd8008f956c844cd3e52affb49bc0b65e451087a1ac9013c0140c595df",
        "repository" => "registry"
      },
      "request"   => {
        "id"        => "fae66612-ef48-4157-8994-bd146fbdd951",
        "addr"      => "127.0.0.1:55452",
        "host"      => "registry.mssola.cat:5000",
        "method"    => "DELETE",
        "useragent" => "Ruby"
      },
      "actor"     => {
        "name" => "portus"
      },
      "source"    => {
        "addr"       => "bucket:5000",
        "instanceID" => "741bc03b-6ebe-4ffc-b6b1-4b33d5fc2090"
      }
    }
  end

  # This is a real even notification as given by docker distribution v2.3
  # rubocop:disable Metrics/LineLength
  let(:version23) do
    {
      "id"        => "7dc1c55c-dfe2-4699-ab0b-8f32e89882ce",
      "timestamp" => "2016-02-05T11:16:14.917994087+01:00",
      "action"    => "push",
      "target"    => {
        "mediaType"  => "application/vnd.docker.distribution.manifest.v1+prettyjws",
        "size"       => 2739,
        "digest"     => "sha256:b9c8a3839b2754e0fc4309e0f994f617d43814996805388e2f9d977db3fa7967",
        "length"     => 2739,
        "repository" => "mssola/lala",
        "url"        => "https://registry.mssola.cat:5000/v2/mssola/lala/manifests/sha256:b9c8a3839b2754e0fc4309e0f994f617d43814996805388e2f9d977db3fa7967"
      },
      "request"   => {
        "id"        => "e30471d8-39c3-41c0-abc2-775ed43e81c9",
        "addr"      => "127.0.0.1:54032",
        "host"      => "registry.mssola.cat:5000",
        "method"    => "PUT",
        "useragent" => "docker/1.9.1 go/go1.5.2 git-commit/a34a1d5 kernel/4.4.0-1-default os/linux arch/amd64"
      },
      "actor"     => {
        "name" => "mssola"
      },
      "source"    => {
        "addr"       => "g67:5000",
        "instanceID" => "18771ece-0887-40f8-ad53-ee46451b4d8b"
      }
    }
  end
  # rubocop:enable Metrics/LineLength

  it "processes all the relevant events" do
    body["events"] << relevant
    body["events"] << delete
    body["events"] << version23
    expect(Repository).to receive(:handle_push_event).with(relevant)
    expect(Repository).to receive(:handle_delete_event).with(delete)
    expect(Repository).to receive(:handle_push_event).with(version23)
    Portus::RegistryNotification.process!(body, Repository)
  end

  it "does not process the same event multiple times" do
    body["events"] = [version23]
    expect(Repository).to receive(:handle_push_event).with(version23)
    Portus::RegistryNotification.process!(body, Repository)

    expect(RegistryEvent.count).to eq 1
    event = RegistryEvent.find_by(event_id: version23["id"])
    expect(event.event_id).to eq version23["id"]
    expect(event.repository).to eq version23["target"]["repository"]

    expect(Repository).to_not receive(:handle_push_event).with(version23)
    Portus::RegistryNotification.process!(body, Repository)

    expect(RegistryEvent.count).to eq 1
  end
end

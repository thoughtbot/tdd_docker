require "serverspec"
require "docker"

describe "Dockerfile" do
  image = Docker::Image.build_from_dir('.')

  set :os, family: :debian
  set :backend, :docker
  set :docker_image, image.id

  it "installs the right version of Ubuntu" do
    expect(os_version).to match(/Ubuntu 14/)
  end

  it "installs required packages" do
    expect(package("nodejs")).to be_installed
  end

  def os_version
    command("lsb_release -a").stdout
  end
end

project_name = 'oneacct-export'
home_dir = '/home/vagrant'
work_dir = "#{home_dir}/#{project_name}"
build_env = { "HOME" => home_dir }

bash 'run_omnibus_build' do
  case node[:platform]
  when 'debian'
    case node[:platform_version]
    when '7.6'
      pkg_dir = 'debian-7'
    when '6.0.10'
      pkg_dir = 'debian-6'
    end
  when 'centos'
    case node[:platform_version]
    when '5.10'
      pkg_dir = 'centos-5'
    when '6.5'
      pkg_dir = 'centos-6'
    end
  when 'ubuntu'
    case node[:platform_version]
    when '10.04'
      pkg_dir = 'ubuntu-10.04'
    when '12.04'
      pkg_dir = 'ubuntu-12.04'
    when '14.04'
      pkg_dir = 'ubuntu-14.04'
    end
  end

  user 'vagrant'
  group 'omnibus'
  environment build_env

  pkg_dir = pkg_dir ? "#{work_dir}/packages/#{pkg_dir}" : "#{work_dir}/packages"
  cwd work_dir
  timeout 7200

  code <<-EOC
    #{home_dir}/.bashrc.d/chruby-default.sh
    chruby-exec 2.1.2 -- bundle install --binstubs
    chruby-exec 2.1.2 -- bundle exec omnibus build #{project_name}

    if [ $? -eq 0 ]; then
      mkdir -p #{pkg_dir}
      cp #{work_dir}/pkg/* #{pkg_dir}
      rm -r #{work_dir}/pkg
    else
      exit 125
    fi
  EOC
end

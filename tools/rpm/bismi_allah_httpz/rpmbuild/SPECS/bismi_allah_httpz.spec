Name:           bismi_allah_httpz
Version:        1.0.0
Release:        1%{?dist}
Summary:        bismi Allah A simple Zig project example
License:        MIT
Source0:        %{name}-%{version}.tar.gz

BuildRequires:  zig

%description
bismi_allah_httpz

%prep
%setup -q

%build
zig build --release=safe

%install
mkdir -p %{buildroot}/usr/local/bin
install -m 0755 zig-out/bin/bismi_allah %{buildroot}/usr/local/bin/bismi_allah_httpz

%files
/usr/local/bin/bismi_allah_httpz

%changelog


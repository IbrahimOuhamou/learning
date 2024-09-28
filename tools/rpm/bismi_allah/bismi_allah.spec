Name:       bismi_allah
Version:    1.0
Release:    1%{?dist}
Summary:    Bismi Allah
License:    MIT
BuildArch:  noarch

%description
Bismi Allah

%prep

%build

%install
mkdir -p %{buildroot}/%{_bindir}
install -m 0755 %{name} %{buildroot}/%{_bindir}/%{name}

%files
%{_bindir}/%{name}

%changelog

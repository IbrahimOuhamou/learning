Name:           quran-warsh
Version:        1.0.0
Release:        1%{?dist}
Summary:        tajweed quran in the warsh 'ورش' reading
License:        MIT
Source0:        %{name}-%{version}.tar.gz

BuildRequires:  zig, CSFML-devel
Requires: CSFML

%description
tajweed quran in the warsh (ورش) reading

%prep
%setup -q

%build
zig build --release=safe

%install
mkdir -p %{buildroot}/usr/local/bin
mkdir -p %{buildroot}/usr/share/quran-warsh
install -m 0755 zig-out/bin/quran-warsh %{buildroot}/usr/local/bin/quran-warsh
install -m 0644 src/res/*.jpg %{buildroot}/usr/share/quran-warsh

%files
/usr/local/bin/quran-warsh
/usr/share/quran-warsh

# %changelog
# * alhamdo li Allah

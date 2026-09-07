# modules/common/timezone.nix
{ ... }: {
  time.timeZone = "America/Denver";
  i18n.defaultLocale = "en_US.UTF-8";
}

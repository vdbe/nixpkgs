{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "tfsec";
  version = "1.28.12";

  src = fetchFromGitHub {
    owner = "aquasecurity";
    repo = "tfsec";
    tag = "v${version}";
    hash = "sha256-ul4KKwTWFg5FxmLhyrQAQWfuCoSVDc6eIchbLwpG/xI=";
  };

  ldflags = [
    "-s"
    "-w"
    "-X=github.com/aquasecurity/tfsec/version.Version=v${version}"
    ## not sure if this is needed (https://github.com/aquasecurity/tfsec/blob/master/.goreleaser.yml#L6)
    # "-extldflags '-fno-PIC -static'"
  ];

  vendorHash = "sha256-yi124OllfSchKSaj+OlxG/7UQcBLdx8JUlnu/a8MSOU=";

  subPackages = [
    "cmd/tfsec"
    "cmd/tfsec-docs"
    "cmd/tfsec-checkgen"
  ];

  meta = with lib; {
    description = "Static analysis powered security scanner for terraform code";
    homepage = "https://github.com/aquasecurity/tfsec";
    changelog = "https://github.com/aquasecurity/tfsec/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [
      fab
      peterromfeldhk
    ];
  };
}

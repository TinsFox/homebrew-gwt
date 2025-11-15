class GitWorktreeCli < Formula
  desc "Git Worktree CLI - A powerful command-line tool for managing Git worktrees"
  homepage "https://github.com/TinsFox/gwt"
  url "https://github.com/TinsFox/gwt/archive/v1.0.0.tar.gz"
  sha256 "b48e46f0a021f8f2ec7e4a27cd8592d8b4dc43cb5c5cfe7a5eeda6abba5fcc91"
  license "MIT"
  head "https://github.com/TinsFox/gwt.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.Version=#{version}")
    
    # Install completion scripts
    output = Utils.safe_popen_read(bin/"git-worktree-cli", "completion", "bash")
    (bash_completion/"git-worktree-cli").write output
    
    output = Utils.safe_popen_read(bin/"git-worktree-cli", "completion", "zsh")
    (zsh_completion/"_git-worktree-cli").write output
    
    output = Utils.safe_popen_read(bin/"git-worktree-cli", "completion", "fish")
    (fish_completion/"git-worktree-cli.fish").write output
  end

  test do
    assert_match "git-worktree-cli version", shell_output("#{bin}/git-worktree-cli --version")
    assert_match "Git Worktree CLI", shell_output("#{bin}/git-worktree-cli --help")
  end
end

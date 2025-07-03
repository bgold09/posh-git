BeforeAll {
    . $PSScriptRoot\Shared.ps1
}

Describe 'ParamsTabExpansion Tests' {
    Context 'Push Parameters TabExpansion Tests' {
        It 'Tab completes all long push parameters' {
            $result = & $module GitTabExpansionInternal 'git push --'
            $result -contains '--all' | Should -Be $true
            $result -contains '--delete' | Should -Be $true
            $result -contains '--dry-run' | Should -Be $true
            $result -contains '--exec=' | Should -Be $true
            $result -contains '--follow-tags' | Should -Be $true
            $result -contains '--force' | Should -Be $true
            $result -contains '--force-with-lease' | Should -Be $true
            $result -contains '--mirror' | Should -Be $true
            $result -contains '--no-force-with-lease' | Should -Be $true
            $result -contains '--no-thin' | Should -Be $true
            $result -contains '--no-verify' | Should -Be $true
            $result -contains '--porcelain' | Should -Be $true
            $result -contains '--progress' | Should -Be $true
            $result -contains '--prune' | Should -Be $true
            $result -contains '--quiet' | Should -Be $true
            $result -contains '--receive-pack=' | Should -Be $true
            $result -contains '--recurse-submodules=' | Should -Be $true
            $result -contains '--repo=' | Should -Be $true
            $result -contains '--set-upstream' | Should -Be $true
            $result -contains '--tags' | Should -Be $true
            $result -contains '--thin' | Should -Be $true
            $result -contains '--verbose' | Should -Be $true
            $result -contains '--verify' | Should -Be $true
        }
        It 'Tab completes all short push parameters' {
            $result = & $module GitTabExpansionInternal 'git push -'
            $result -contains '-f' | Should -Be $true
            $result -contains '-n' | Should -Be $true
            $result -contains '-q' | Should -Be $true
            $result -contains '-u' | Should -Be $true
            $result -contains '-v' | Should -Be $true
        }
        It 'Tab completes push parameters values' {
            $result = & $module GitTabExpansionInternal 'git push --recurse-submodules='
            $result -contains '--recurse-submodules=check' | Should -Be $true
            $result -contains '--recurse-submodules=on-demand' | Should -Be $true
        }
    }

    Context 'Pretty/Format TabCompletion Tests - No Custom Formats' {
        It 'Tab completes default formats for log --pretty' {
            $result = & $module GitTabExpansionInternal 'git log --pretty='
            $result -contains '--pretty=oneline' | Should -Be $true
            $result -contains '--pretty=short' | Should -Be $true
            $result -contains '--pretty=medium' | Should -Be $true
            $result -contains '--pretty=full' | Should -Be $true
            $result -contains '--pretty=fuller' | Should -Be $true
            $result -contains '--pretty=email' | Should -Be $true
            $result -contains '--pretty=raw' | Should -Be $true
        }
        It 'Tab completes default formats for log --format' {
            $result = & $module GitTabExpansionInternal 'git log --format='
            $result -contains '--format=oneline' | Should -Be $true
            $result -contains '--format=short' | Should -Be $true
            $result -contains '--format=medium' | Should -Be $true
            $result -contains '--format=full' | Should -Be $true
            $result -contains '--format=fuller' | Should -Be $true
            $result -contains '--format=email' | Should -Be $true
            $result -contains '--format=raw' | Should -Be $true
        }
        It 'Tab completes default formats for show --pretty' {
            $result = & $module GitTabExpansionInternal 'git show --pretty='
            $result -contains '--pretty=oneline' | Should -Be $true
            $result -contains '--pretty=short' | Should -Be $true
            $result -contains '--pretty=medium' | Should -Be $true
            $result -contains '--pretty=full' | Should -Be $true
            $result -contains '--pretty=fuller' | Should -Be $true
            $result -contains '--pretty=email' | Should -Be $true
            $result -contains '--pretty=raw' | Should -Be $true
        }
        It 'Tab completes default formats for show --format' {
            $result = & $module GitTabExpansionInternal 'git show --format='
            $result -contains '--format=oneline' | Should -Be $true
            $result -contains '--format=short' | Should -Be $true
            $result -contains '--format=medium' | Should -Be $true
            $result -contains '--format=full' | Should -Be $true
            $result -contains '--format=fuller' | Should -Be $true
            $result -contains '--format=email' | Should -Be $true
            $result -contains '--format=raw' | Should -Be $true
        }
    }

    Context 'Pretty/Format TabCompletion Tests - With Custom Formats' {
        BeforeEach {
            [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssigments', '')]
            $repoPath = NewGitTempRepo

            # Test with custom formats
            &$gitbin config pretty.birdseye "%C(auto)%h%d %s %C(bold blue)<%aN> %C(green)(%cr)%Creset"
            &$gitbin config pretty.test2 "%h%d %s <%aN> (%cr)"
        }
        AfterEach {
            RemoveGitTempRepo $repoPath
        }

        It 'Tab completes default and custom formats for log --pretty' {
            $result = & $module GitTabExpansionInternal 'git log --pretty='
            $result -contains '--pretty=oneline' | Should -Be $true
            $result -contains '--pretty=short' | Should -Be $true
            $result -contains '--pretty=medium' | Should -Be $true
            $result -contains '--pretty=full' | Should -Be $true
            $result -contains '--pretty=fuller' | Should -Be $true
            $result -contains '--pretty=email' | Should -Be $true
            $result -contains '--pretty=raw' | Should -Be $true
            $result -contains '--pretty=birdseye' | Should -Be $true
            $result -contains '--pretty=test2' | Should -Be $true
        }
        It 'Tab completes default and custom formats for log --format' {
            $result = & $module GitTabExpansionInternal 'git log --format='
            $result -contains '--format=oneline' | Should -Be $true
            $result -contains '--format=short' | Should -Be $true
            $result -contains '--format=medium' | Should -Be $true
            $result -contains '--format=full' | Should -Be $true
            $result -contains '--format=fuller' | Should -Be $true
            $result -contains '--format=email' | Should -Be $true
            $result -contains '--format=raw' | Should -Be $true
            $result -contains '--format=birdseye' | Should -Be $true
            $result -contains '--format=test2' | Should -Be $true
        }
        It 'Tab completes default and custom formats for show --pretty' {
            $result = & $module GitTabExpansionInternal 'git show --pretty='
            $result -contains '--pretty=oneline' | Should -Be $true
            $result -contains '--pretty=short' | Should -Be $true
            $result -contains '--pretty=medium' | Should -Be $true
            $result -contains '--pretty=full' | Should -Be $true
            $result -contains '--pretty=fuller' | Should -Be $true
            $result -contains '--pretty=email' | Should -Be $true
            $result -contains '--pretty=raw' | Should -Be $true
            $result -contains '--pretty=birdseye' | Should -Be $true
            $result -contains '--pretty=test2' | Should -Be $true
        }
        It 'Tab completes default and custom formats for show --format' {
            $result = & $module GitTabExpansionInternal 'git show --format='
            $result -contains '--format=oneline' | Should -Be $true
            $result -contains '--format=short' | Should -Be $true
            $result -contains '--format=medium' | Should -Be $true
            $result -contains '--format=full' | Should -Be $true
            $result -contains '--format=fuller' | Should -Be $true
            $result -contains '--format=email' | Should -Be $true
            $result -contains '--format=raw' | Should -Be $true
            $result -contains '--format=birdseye' | Should -Be $true
            $result -contains '--format=test2' | Should -Be $true
        }
    }

    Context 'Sparse-Checkout TabExpansion Tests' {
        It 'Tab completes sparse-checkout subcommands' {
            $result = & $module GitTabExpansionInternal 'git sparse-checkout '
            $result -contains 'list' | Should -Be $true
            $result -contains 'set' | Should -Be $true
            $result -contains 'add' | Should -Be $true
            $result -contains 'reapply' | Should -Be $true
            $result -contains 'disable' | Should -Be $true
            $result -contains 'init' | Should -Be $true
            $result -contains 'check-rules' | Should -Be $true
        }

        It 'Tab completes sparse-checkout set long parameters' {
            $result = & $module GitTabExpansionInternal 'git sparse-checkout set --'
            $result -contains '--cone' | Should -Be $true
            $result -contains '--no-cone' | Should -Be $true
            $result -contains '--sparse-index' | Should -Be $true
            $result -contains '--no-sparse-index' | Should -Be $true
            $result -contains '--stdin' | Should -Be $true
        }

        It 'Tab completes sparse-checkout add long parameters' {
            $result = & $module GitTabExpansionInternal 'git sparse-checkout add --'
            $result -contains '--cone' | Should -Be $true
            $result -contains '--no-cone' | Should -Be $true
            $result -contains '--sparse-index' | Should -Be $true
            $result -contains '--no-sparse-index' | Should -Be $true
            $result -contains '--stdin' | Should -Be $true
        }

        It 'Tab completes sparse-checkout reapply long parameters' {
            $result = & $module GitTabExpansionInternal 'git sparse-checkout reapply --'
            $result -contains '--cone' | Should -Be $true
            $result -contains '--no-cone' | Should -Be $true
            $result -contains '--sparse-index' | Should -Be $true
            $result -contains '--no-sparse-index' | Should -Be $true
        }

        It 'Tab completes sparse-checkout init long parameters' {
            $result = & $module GitTabExpansionInternal 'git sparse-checkout init --'
            $result -contains '--cone' | Should -Be $true
            $result -contains '--no-cone' | Should -Be $true
            $result -contains '--sparse-index' | Should -Be $true
            $result -contains '--no-sparse-index' | Should -Be $true
        }

        It 'Tab completes sparse-checkout check-rules long parameters' {
            $result = & $module GitTabExpansionInternal 'git sparse-checkout check-rules --'
            $result -contains '--rules-file=' | Should -Be $true
            $result -contains '--no-cone' | Should -Be $true
            $result -contains '--z' | Should -Be $true
        }

        It 'Tab completes sparse-checkout check-rules short parameters' {
            $result = & $module GitTabExpansionInternal 'git sparse-checkout check-rules -'
            $result -contains '-z' | Should -Be $true
        }

        It 'Does not complete parameters for sparse-checkout list' {
            $result = & $module GitTabExpansionInternal 'git sparse-checkout list --'
            $result.Count | Should -Be 0  # list doesn't accept any parameters
        }

        It 'Does not complete parameters for sparse-checkout disable' {
            $result = & $module GitTabExpansionInternal 'git sparse-checkout disable --'
            $result.Count | Should -Be 0  # disable doesn't accept any parameters
        }

        It 'Tab completes partial sparse-checkout subcommands' {
            $result = & $module GitTabExpansionInternal 'git sparse-checkout se'
            $result -contains 'set' | Should -Be $true
        }

        It 'Tab completes partial sparse-checkout set parameters' {
            $result = & $module GitTabExpansionInternal 'git sparse-checkout set --co'
            $result -contains '--cone' | Should -Be $true
        }

        It 'Tab completes partial sparse-checkout check-rules parameters' {
            $result = & $module GitTabExpansionInternal 'git sparse-checkout check-rules --ru'
            $result -contains '--rules-file=' | Should -Be $true
        }
    }

    Context 'Sparse-Checkout File Completion Tests' {
        BeforeEach {
            [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssigments', '')]
            $repoPath = NewGitTempRepo

            # Create some test files that could be rules files
            'rule1' | Out-File -FilePath 'test.rules' -Encoding ascii
            'rule2' | Out-File -FilePath 'patterns.txt' -Encoding ascii
            'rule3' | Out-File -FilePath 'sparse-rules' -Encoding ascii
            'other' | Out-File -FilePath 'README.md' -Encoding ascii
        }
        AfterEach {
            RemoveGitTempRepo $repoPath
        }

        It 'Tab completes rules files for --rules-file parameter' {
            $result = & $module GitTabExpansionInternal 'git sparse-checkout check-rules --rules-file='
            $result -contains 'test.rules' | Should -Be $true
            $result -contains 'patterns.txt' | Should -Be $true
            $result -contains 'sparse-rules' | Should -Be $true
            $result -contains 'README.md' | Should -Be $false  # .md files should not be suggested
        }

        It 'Tab completes partial rules file names' {
            $result = & $module GitTabExpansionInternal 'git sparse-checkout check-rules --rules-file=test'
            $result -contains 'test.rules' | Should -Be $true
            $result -contains 'patterns.txt' | Should -Be $false
            $result -contains 'sparse-rules' | Should -Be $false
        }
    }
}


pipeline {
  agent {
    node {
      label 'master'
    }
  }
  stages {
    stage('Cleanup') {
      steps {
        deleteDir()
      }
    }
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
    stage('Build asm and pdf') {
      agent {
        dockerfile {
          reuseNode true
        }
      }
      steps {
        sh script: 'make'
        sh """
          cd bootloader
          make
        """
      }
    }
    stage('Archive Artifacts') {
      steps {
        archiveArtifacts 'bootloader/bootloader'
        archiveArtifacts 'bootloader/bootloader.pdf'
        archiveArtifacts 'bootloader/makebootfloppy.sh'
        archiveArtifacts 'tutorial.pdf'
      }
    }
    stage('Update gh-pages from master') {
      when {
        environment name: 'CHANGE_FORK', value: ''
        expression { GIT_URL ==~ 'https://github.com/osdevelopment-info/.*' }
        expression { GIT_BRANCH ==~ 'master' }
        expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
      }
      steps {
        sshagent(['6452f2aa-2b69-4fa7-be5f-5f0ef6d3acba']) {
          sh """
            git clone --no-checkout \$(echo ${GIT_URL} | sed 's/https:\\/\\//git@/' | sed 's/\\//:/') checkout
            git config --add user.email ci@sw4j.org
            git config --add user.name "CI Jenkins"
            git config push.default simple
            cd checkout
            git checkout gh-pages
            mkdir -p bootloader/
            cp ../*.pdf .
            cp ../bootloader/bootloader bootloader/
            cp ../bootloader/bootloader.pdf bootloader/
            cp ../bootloader/makebootfloppy.sh bootloader/
            git diff --quiet && git diff --staged --quiet || git commit -am 'Update program and documentation'
            git push
            cd ..
            rm -rf checkout
          """
        }
      }
    }
  }
}

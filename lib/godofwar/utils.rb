module GodOfWar
  module Utils

    # fix target/project name if the target is a URL (eg. http://example.com/app1/route2/ to be example.com-app1-route2)
    #
    # @return [String]
    def fix_project_naming(project)
      project.gsub(/http[:|s]+\/\//, '').gsub('/', '-').gsub(/-*$/, '')
    end

    def self.logo
      slogan = 'The Cyber Daemons - '.reset + 'TechArch'.bold
      %Q{
              ______
        '!!""""""""""""*!!'
     .u$"!'            .!!"$"
     *$!        'z`        ($!
     +$-       .$$&`       !$!
     +$-      `$$$$3       !$!
     +$'   !!  '!$!   !!   !$!
     +$'  ($$.  !$!  '$$!  !$!
     +$'  $$$$  !$!  $$$$  !$!
     +$'  .$"   !$!   3$   !$!
     ($!  `$%`  !3!  .$%   ($!
      ($(` '"$!    `*$"` ."$!
       `($(` '"$!.($". ."$!
         `($(` !$$%. ."$!
           `!$%$! !$%$!
              `     `
                     #{slogan}
      }.red.bold
    end

    # banner
    def self.banner
      <<~BANNER
                                                         `           
                                                        :hho/.`      
                                                       -hdddddhs/.   
                                                      .hddddddddy`   
                                                     .hddddddddh.    
                                                    `yddddddddh.     
                                                   `sddddddddh-      
                                                  `sddddddddd:       
                                                  oddddddddd:        
                                                 +ddddddddd/         
                                      `o-       /ddddddddd+          
                                     .y+       /dddddddddo`          
                                    .h/       :dddddddddd+`          
                            .      .h/       `yddddddddddd+`         
                           `dy/.  `y+         /ddddddddddddo`  `....`
                            hMMNy+ss          `yddddddddddddo:ohmNNNs
                            +MMMMMMd+-`        /dddddmmmmNNMMMMMMMMm/
                            +MMMMMMMMNdo:`     +MNNNMMMMMMMMNmNMMMm.
                          `oMMNosMMMmdNMMNy:/.`/omMMMMNomMMN+`/NMNo
                         .hMMMms+ydh+/yNNNNs:    `yNMMo+odmhydMMN+ 
                         /+//::m/-:////:--+ `      ./NMMMMMMMMNmds 
                              +y          ` o.  .`   `:yNNmmmddddd+
                             `m-            d-  hs     `ydddddddddd: 
                             /h        :yy/`h  .omy: -` .hdddddddddh.
                             h/       /h-.:o-    +y  -h/ -ddddddddddy
                            `m`       /`o/  `    `` .`.d+ /dddddho:.`
                            -m         .+dyo`     .ys` `o+`+dddd-    
                            .+          .+s:///::`-.     `  ydds     
                                          `` ````           +dd-     
                                      -:-.`        `.`      -do      
                                     /NNddddhysyhddddm/     `h.      
                                   `odo-``..:/o+:-.../h+`    -
                                   :-`   ---------.   `:/`    
                                        `NNNNNNNNNN     ``    
                                        `NNNNMMMMNN       
                                         ----hMMs-.       
                                            `hMM+          ``
                                 `-..```  ./hMMM/ ``   `.:oh-
                                 .ymmddhhymMMMMMyyds.:shmMMo 
                                  `sNMMMMMMMMMMMMMMMNMMMMMy` 
                                    /NMMMMMMMMMMMMMMMMMMMm.  
                                     -dMMMMMMMMMMMMMMMMNm:   
                                      .yMMMMMMMMMMMMMMo-`    
                                       `oNMMMMMMMMMMNNy      
                                         :+NMMNNmho/-`       
                                             /o/-`
                                                                                  

      BANNER
    end

    # ask method for interactive session with user
    def ask(question, expected_answer)
      answer = ''
      until answer.match?(expected_answer)
        answer = Readline.readline(question, true)
      end

      answer
    end
  end
end
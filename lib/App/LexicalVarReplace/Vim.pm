package App::LexicalVarReplace::Vim;

1;

__END__

=head1 NAME

App::LexicalVarReplace::Vim - Helper to add Vim bindings for App::LexicalVarReplace::Vim
Lexically replace a variable name in Perl code

=head1 SYNOPSIS
    
    map ,pL :call LexicalVarReplace()<cr>
    function! LexicalVarReplace()
        let newvar = input("New variable name? ")
        if newvar == ""
            echo "cancelling"
            return
        endif

        let line = line('.')
        " should backtrack to $ or % or the like
        let col  = col('.')
        let filename = expand('%')

        let command = "vim_lexvarrepl --col " . col .
            \ " --line " . line . " --new " . newvar 
        echo command

        let buffer_contents = join( getline(1,"$"), "\n" )
        let result_str = system(command, buffer_contents )
        let result = split( result_str, "\n" )
        call setline( 1, result )
    endfunction

=head1 DESCRIPTION

Eventually this module will somehow provide a helper to add the mapping to
C<vim_lexvarrepl> to vim. For now add the code in the SYNOPSIS to your a file
under C<$HOME/.vim/ftplugin/perl/> (ie. 
C<$HOME/.vim/ftplugin/perl/lexvarrepl.vim>)

=head1 SEE ALSO

L<App::LexicalVarReplace>, L<Padre>, and L<PPI>.

=head1 AUTHOR

Mark V. Grimes, E<lt>E<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Mark Grimes

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.2 or,
at your option, any later version of Perl 5 you may have available.

=cut

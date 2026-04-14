\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ritr-ll851}

\newif\if@BOXED
\@BOXEDfalse
\newif\if@TWOSIDED
\@TWOSIDEDfalse

\DeclareOption{boxed}{%
    \@BOXEDtrue
}

\DeclareOption{twosided}{%
    \@TWOSIDEDtrue
}
\ProcessOptions\relax

\LoadClass{book}

\RequirePackage{boxedminipage}
\RequirePackage[
    landscape,
    top=0.9in,
    bottom=0.5in,
    inner=1.125in,
    outer=0.85in
]{geometry}

\newcommand{\FrontPage}[1]{\def\@FRONT{#1}}
\newcommand{\BackPage}[1]{\def\@BACK{#1}}
\newlength{\RitrTextWidth}
\setlength{\RitrTextWidth}{3.8in}
\newcounter{face}

\pagestyle{empty}
\setlength{\parindent}{0pt}

\AddToHook{begindocument/end}{%
\if@BOXED
    \begin{boxedminipage}[t][6.5in][t]{3.9in}
        \stepcounter{face}
        \@FRONT
    \end{boxedminipage}
    \hspace{1.1in}
    \begin{boxedminipage}[t][6.5in][t]{3.9in}
        \stepcounter{face}
        \@FRONT
    \end{boxedminipage}
\else
    \begin{minipage}[t][6.5in][t]{3.9in}
        \stepcounter{face}
        \@FRONT
    \end{minipage}
    \hspace{1.1in}
    \begin{minipage}[t][6.5in][t]{3.9in}
        \stepcounter{face}
        \@FRONT
    \end{minipage}
\fi

\if@TWOSIDED
    \pagebreak

    \if@BOXED
        \begin{boxedminipage}[t][6.5in][t]{3.9in}
            \stepcounter{face}
            \@BACK
        \end{boxedminipage}
        \hspace{1.1in}
        \begin{boxedminipage}[t][6.5in][t]{3.9in}
            \stepcounter{face}
            \@BACK
        \end{boxedminipage}
    \else
        \begin{minipage}[t][6.5in][t]{3.9in}
            \stepcounter{face}
            \@BACK
        \end{minipage}
        \hspace{1.1in}
        \begin{minipage}[t][6.5in][t]{3.9in}
            \stepcounter{face}
            \@BACK
        \end{minipage}
    \fi
\fi

}

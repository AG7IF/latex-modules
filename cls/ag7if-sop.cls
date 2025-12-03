\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ag7if-sop}

% \documentclass[<draft>]{ag7if-sop}
%
% \controlNumber{<CONTROL_NUMBER>}
% \title{<TITLE>}
% \revision{<DATE>}
% \seal{<SEAL>}
%
% \begin{document}
%   \maketitle
% \end{document}

\DeclareOption{draft}{%
    \newcommand{\@draft}{}
}

\ProcessOptions\relax

\LoadClass[10pt]{extbook}

\RequirePackage{ag7if-checklist}
\RequirePackage{booktabs}
\RequirePackage{fancyhdr}
\RequirePackage{graphicx}
\RequirePackage[
    paperwidth=5in, 
    paperheight=8in, 
    top=0.75in,
    bottom=0.75in,
    left=0.25in,
    right=0.25in
]{geometry}
\RequirePackage{tocloft}

\ifdefined\@draft
    \RequirePackage{draftwatermark}
\fi

%Page formatting
\setlength{\parindent}{0pt}
\fancypagestyle{plain}{\fancyhf{}}
\renewcommand{\headrulewidth}{0pt}
\fancyhf{}
\fancyhead[RO,LE]{\thepage}
\fancyfoot[L]{%
    \ifdefined\@draft
        DRAFT
    \else
        \@revision
    \fi
}
\fancyfoot[R]{\@controlNumber}
\pagestyle{fancy}

% TOC formatting
\renewcommand{\contentsname}{}
\renewcommand{\cftbeforetoctitleskip}{0pt}
\renewcommand{\cftaftertoctitleskip}{-20pt}
%\renewcommand{\cftparskip}{-3pt}
%\renewcommand{\cftchapfont}{\normalsize\bfseries}
%\renewcommand{\cftsecfont}{\normalsize}
%\renewcommand{\cftchappagefont}{\normalsize\bfseries}
%\renewcommand{\cftsecpagefont}{\normalsize}

% Titlepage definitions
\newcommand{\controlNumber}[1]{%
    \def\@controlNumber{#1}
}

\newcommand{\revision}[1]{%
    \def\@revision{#1}
}

\newcommand{\seal}[1]{%
    \def\@seal{#1}
}

\renewcommand{\maketitle}{%
    \thispagestyle{plain}
    \begin{center}
        \vspace*{\fill}

        \Large
        \@controlNumber%
        
        \vspace{1em}

        \@title%

        \vspace{4em}

        \includegraphics[height=2in]{\@seal}
        
        \vspace{2em}
        
        \ifdefined\@draft
            Revision DRAFT
        \else
            Revision\ \@revision
        \fi

        \vfill
    \end{center}   
    
    \cleardoublepage
}

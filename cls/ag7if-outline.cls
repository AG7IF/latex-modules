\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ag7if-outline}

% Document Setup:
%
% \documentclass[<draft>,<short>,<refs>]{ag7if-outline}
%
% \controlNumber{<CONTROL_NUMBER>} % Optional
% \title{<TITLE>}
% \date{<DATE>}
%
% \draftStarted{<DATE>}
% \draftCompleted{<DATE>}
% \proofreadCompleted{<DATE>}
% \reviewCompleted{<DATE>}
%
% \author{<AUTHOR>}
% \authorOffice{<OFFICE_SYMBOL>}
% \authorContact{<PHONE_NUMBER>}
% \typist{<TYPIST_INITIALS>}
%
% \begin{document}
% \maketitle
%
% \begin{itemize}
%   \item <ITEM>
%   \item <ITEM>
%   \begin{itemize}
%       \item <SUBITEM>
%       \item <SUBITEM>
%   \end{itemize}
% \end{itemize}
% \end{document}

\DeclareOption{draft}{%
    \RequirePackage{draftwatermark}
}
\DeclareOption{short}{%
    \PassOptionsToPackage{short}{chicago-outline}
}
\DeclareOption{refs}{%
    \RequirePackage[backend=biber, style=numeric]{biblatex}
    \addbibresource{references.bib}
}
\ProcessOptions\relax

\LoadClass[12pt]{article}

\RequirePackage[
    margin=1in,
    headheight=15pt,
    footskip=0.5in
]{geometry}

\RequirePackage{chicago-outline}
\RequirePackage{enumitem}
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}
\RequirePackage{usaf-pub}

% Class Commmands
\renewcommand{\title}[1]{%
    \def\@title{#1}
}
\newcommand{\controlNumber}[1]{\def\@controlNumber{#1}}
\newcommand{\authorOffice}[1]{\def\@authorOffice{#1}}
\newcommand{\authorContact}[1]{\def\@authorContact{#1}}
\newcommand{\typist}[1]{\def\@typist{#1}}
\newcommand{\IdentLine}{%
    \ifdefined\@draft
        \@author/\@authorOffice/\@authorContact/\@typist/DRAFT
    \else
        \@author/\@authorOffice/\@authorContact/\@typist/\@date
    \fi
}
\newcommand{\draftStarted}[1]{\def\@draftStarted{#1}}
\newcommand{\draftCompleted}[1]{\def\@draftCompleted{#1}}
\newcommand{\proofreadCompleted}[1]{\def\@proofreadCompleted{#1}}
\newcommand{\reviewCompleted}[1]{\def\@reviewCompleted{#1}}

% Formatting
\titleformat{\section}{\normalfont\MakeUppercase}{\thesection}{0pt}{}
\titlespacing{\section}{0pt}{1em}{1em}

\titleformat{\subsection}{\normalfont}{\thesubsection}{0pt}{\underline}
\titlespacing{\subsection}{0pt}{1em}{1em}

\titleformat{\subsubsection}{\normalfont}{\thesubsubsection}{0pt}{\textit}
\titlespacing{\subsubsection}{0pt}{1em}{1em}

\fancypagestyle{firstpage}{%
    \fancyhf{}
    \ifdefined\@PaperInfosecLvlSet
        \fancyfoot[L]{\raisebox{1.5em}{\IdentLine}}
        \fancyhead[C]{\InfosecLevel}
        \fancyfoot[C]{\InfosecLevel}
        \ifdefined\@PaperTlpLvlSet
            \fancyhead[R]{\TLPLevel}
            \fancyfoot[R]{\TLPLevel}
        \fi
    \else
        \fancyfoot[L]{\IdentLine}
    \fi
}

\pagestyle{usaf}

\newcommand{\PaperTitle}{%
    \thispagestyle{firstpage}
    \begin{center}
        \ifdefined\@controlNumber
            OUTLINE~\@controlNumber\vspace{1em}
        \else
            OUTLINE\vspace{1em}
        \fi

        FOR\vspace{1em}

        \MakeUppercase{\@title}
    \end{center}
}

\renewcommand{\maketitle}{%
    \PaperTitle%

    \section*{Progress}

    \begin{center}
    \begin{tabular}{|l|r|}
    \hline
        \textbf{Outline Date}        & \ifdefined\@draft DRAFT\else\@date\fi \\
    \hline
        \textbf{Draft Started}       &                        \@draftStarted \\
    \hline
        \textbf{Draft Completed}     &                      \@draftCompleted \\
    \hline
        \textbf{Proofread Completed} &                  \@proofreadCompleted \\
    \hline
        \textbf{Review Completed}    &                     \@reviewCompleted \\
    \hline
    \end{tabular}

    \hspace{1em}

    \begin{tabular}{cl}
        \checkboxUnchecked & \textbf{Outline Superseded} \\
    \end{tabular}
    \end{center}
}

\AtEndDocument{\printbibliography[title={References}]}

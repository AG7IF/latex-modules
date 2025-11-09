\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{usaf-paper}

% Document Setup:
%
% \documentclass[<draft>,<paper_type>]{usafpaper}
%
% \controlNumber{<CONTROL_NUMBER>} % Optional
% \title{<TITLE>}
% \date{<DATE>}
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
    \newcommand{\DRAFT}{}
}
\DeclareOption{fouo}{%
    \newcommand{\FOUO}{}
}
\DeclareOption{point}{%
    \newcommand{\@papertype}{POINT}
}
\DeclareOption{talking}{%
    \newcommand{\@papertype}{TALKING}
}
\DeclareOption{background}{%
    \newcommand{\@papertype}{BACKGROUND}
}
\DeclareOption{bullet-background}{%
    \newcommand{\@papertype}{BULLET BACKGROUND}
}
\DeclareOption{position}{%
    \newcommand{\@papertype}{POSITION}
}
\DeclareOption{outline}{%
    \newcommand{\OUTLINE}{}
    \newcommand{\@papertype}{OUTLINE}
}
\DeclareOption{short}{%
    \newcommand{\@SHORT}{}
}
\DeclareOption{very-sensitive}{%
    \newcommand{\@PaperInfosecLvlSet}{}
    \newcommand{\@PaperLvlVerySensitive}{}
}
\DeclareOption{sensitive}{%
    \newcommand{\@PaperInfosecLvlSet}{}
    \newcommand{\@PaperLvlSensitive}{}
}
\DeclareOption{somewhat-sensitive}{%
    \newcommand{\@PaperInfosecLvlSet}{}
    \newcommand{\@PaperLvlSomewhatSensitive}{}
}
\DeclareOption{not-sensitive}{%
    \newcommand{\@PaperInfosecLvlSet}{}
    \newcommand{\@PaperLvlNotSensitive}{}
}
\DeclareOption{tlp-red}{%
    \newcommand{\@PaperTlpLvlSet}{}
    \newcommand{\@PaperTlpRed}{}
}
\DeclareOption{tlp-amber-strict}{%
    \newcommand{\@PaperTlpLvlSet}{}
    \newcommand{\@PaperTlpAmberStrict}{}
}
\DeclareOption{tlp-amber}{%
    \newcommand{\@PaperTlpLvlSet}{}
    \newcommand{\@PaperTlpAmber}{}
}
\DeclareOption{tlp-green}{%
    \newcommand{\@PaperTlpLvlSet}{}
    \newcommand{\@PaperTlpGreen}{}
}
\DeclareOption{tlp-clear}{%
    \newcommand{\@PaperTlpLvlSet}{}
    \newcommand{\@PaperTlpClear}{}
}
\ProcessOptions\relax

\LoadClass[12pt]{article}

\RequirePackage[
    margin=1in,
    headheight=15pt,
    footskip=0.5in
]{geometry}
\RequirePackage{enumitem}
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}
\ifdefined\@PaperInfosecLvlSet
    \def\@securityMark{PLACEHOLDER}
    \ifdefined\@PaperTlpLvlSet
        \def\@tlpMark{PLACEHOLDER}
    \fi
    \RequirePackage{usaf-pub}
    \ifdefined\@PaperLvlVerySensitive
        \RequirePackage[very-sensitive]{ag7if-infosec}
    \else\ifdefined\@PaperLvlSensitive
        \RequirePackage[sensitive]{ag7if-infosec}
    \else\ifdefined\@PaperLvlSomewhatSensitive
        \RequirePackage[somewhat-sensitive]{ag7if-infosec}
    \else\ifdefined\@PaperLvlNotSensitive
        \RequirePackage[not-sensitive]{ag7if-infosec}
    \fi\fi\fi\fi
    \ifdefined\@PaperTlpRed
        \RequirePackage[tlp-red]{cert-tlp}
    \else\ifdefined\@PaperTlpAmberStrict
        \RequirePackage[tlp-amber-strict]{cert-tlp}
    \else\ifdefined\@PaperTlpAmber
        \RequirePackage[tlp-amber]{cert-tlp}
    \else\ifdefined\@PaperTlpGreen
        \RequirePackage[tlp-green]{cert-tlp}
    \else\ifdefined\@PaperTlpClear
        \RequirePackage[tlp-clear]{cert-tlp}
    \fi\fi\fi\fi\fi
    \def\@securityMark{\InfosecLevel}
    \ifdefined\@PaperTlpLvlSet
        \def\@tlpMark{\TLPLevel}
    \fi
\else
    \RequirePackage{usaf-pub}
\fi
\ifdefined\DRAFT
    \RequirePackage{draftwatermark}
\fi

% Class Commmands
\newcommand{\controlNumber}[1]{\def\@controlNumber{#1}}
\newcommand{\authorOffice}[1]{\def\@authorOffice{#1}}
\newcommand{\authorContact}[1]{\def\@authorContact{#1}}
\newcommand{\typist}[1]{\def\@typist{#1}}
\newcommand{\IdentLine}{\@author/\@authorOffice/\@authorContact/\@typist/\@date}

% Formatting
\titleformat{\section}{\normalfont\MakeUppercase}{\thesection}{0pt}{}
\titlespacing{\section}{0pt}{0pt}{0pt}

\titleformat{\subsection}{\normalfont}{\thesubsection}{0pt}{\underline}
\titlespacing{\subsection}{0pt}{0pt}{0pt}

\titleformat{\subsubsection}{\normalfont}{\thesubsubsection}{0pt}{\textit}
\titlespacing{\subsubsection}{0pt}{0pt}{0pt}

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
        \ifdefined\OUTLINE
            OUTLINE\vspace{1em}

            FOR\vspace{1em}

            \MakeUppercase{\@title}
        \else
            \ifdefined\@controlNumber
                \@papertype~PAPER~\@controlNumber\vspace{1em}
            \else
                \@papertype~PAPER\vspace{1em}
            \fi

            ON\vspace{1em}

            \MakeUppercase{\@title}
        \fi
    \end{center}
}

\renewcommand{\maketitle}{%
    \PaperTitle%
}

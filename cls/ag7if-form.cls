\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ag7if-form}

\newlength{\@paperHeight}
\newlength{\@paperWidth}
\newlength{\@topMargin}
\newlength{\@bottomMargin}
\newlength{\@leftMargin}
\newlength{\@rightMargin}

\setlength{\@paperHeight}{11.0in}
\setlength{\@paperWidth}{8.5in}
\setlength{\@topMargin}{1.0in}
\setlength{\@bottomMargin}{1.0in}
\setlength{\@leftMargin}{0.5in}
\setlength{\@rightMargin}{0.5in}

\newif\if@landscape

\DeclareOption{landscape}{\@landscapetrue}

\DeclareOption{card-small}{%
    \setlength{\@paperHeight}{5.0in}
    \setlength{\@paperWidth}{3.0in}
    \setlength{\@topMargin}{0.1in}
    \setlength{\@bottomMargin}{0.1in}
    \setlength{\@leftMargin}{0.1in}
    \setlength{\@rightMargin}{0.1in}
}

\DeclareOption{card-medium}{%
    \setlength{\@paperHeight}{6.0in}
    \setlength{\@paperWidth}{4.0in}
    \setlength{\@topMargin}{0.1in}
    \setlength{\@bottomMargin}{0.1in}
    \setlength{\@leftMargin}{0.1in}
    \setlength{\@rightMargin}{0.1in}
}

\DeclareOption{card-large}{%
    \setlength{\@paperHeight}{8.0in}
    \setlength{\@paperWidth}{5.0in}
    \setlength{\@topMargin}{1.0in}
    \setlength{\@bottomMargin}{1.0in}
    \setlength{\@leftMargin}{0.5in}
    \setlength{\@rightMargin}{0.5in}
}

\DeclareOption{quarto}{%
    \setlength{\@paperHeight}{8.5in}
    \setlength{\@paperWidth}{5.5in}
    \setlength{\@topMargin}{1.0in}
    \setlength{\@bottomMargin}{1.0in}
    \setlength{\@leftMargin}{0.5in}
    \setlength{\@rightMargin}{0.5in}
}

\ProcessOptions\relax

\LoadClass{article}

\RequirePackage[hidelinks]{hyperref}
\RequirePackage{tabularx}
\RequirePackage{ag7if-form}

\if@landscape
    \RequirePackage[
        paperheight=\@paperWidth,
        paperwidth=\@paperHeight,
        top=\@topMargin,
        bottom=\@bottomMargin,
        left=\@leftMargin,
        right=\@rightMargin
    ]{geometry}
\else
    \RequirePackage[
        paperheight=\@paperHeight,
        paperwidth=\@paperWidth,
        top=\@topMargin,
        bottom=\@bottomMargin,
        left=\@leftMargin,
        right=\@rightMargin
    ]{geometry}
\fi

\RequirePackage{fancyhdr}
\RequirePackage{lastpage}

\renewcommand{\headrulewidth}{0pt}
\setlength{\headheight}{25pt}
\setlength{\parindent}{0pt}

\newcommand{\IncidentHeader}{%
    \begin{tabularx}{\textwidth}{|p{2.1in}|X|}
        \hline
        \textbf{Incident Name:}
            \newline
            \FormTextBoxL{2.1in}{incident}
        &
        \textbf{Operational Period:}
            ~Date From: \FormTextBoxR{0.75in}{datefrom}
            ~Date To: \FormTextBoxR{0.75in}{dateto}
            \newline
            \hspace*{1.6in}
            ~Time From: \FormTextBoxR{0.75in}{timefrom}
            ~Time To: \FormTextBoxR{0.75in}{timeto}
         \\ \hline
    \end{tabularx}
}

\newcommand{\ProjectHeader}{%
    \begin{tabularx}{\textwidth}{|l|X|l|X|l|}
        \hline
            Domain:                                 &
            Context:                                &
            \multicolumn{2}{l|}{Project:}           &
            Initiated:                              \\
            \FormTextBoxL{0.8in}{domain}            &
            \FormTextBoxL{2.0in}{context}           &
            \FormTextBoxL{0.8in}{projID}            &
            \FormTextBoxL{2.0in}{project}           &
            \FormTextBoxR{0.85in}{initiated}        \\
        \hline
            \multicolumn{2}{|l|}{Campaign:} &
            \multicolumn{2}{l|}{Program/Superproject:} &
            Disposed:                               \\ 
            \FormTextBoxL{0.8in}{campID}            &
            \FormTextBoxL{2.0in}{campaign}          &
            \FormTextBoxL{0.8in}{superID}           &
            \FormTextBoxL{2.0in}{superproject}      &
            \FormTextBoxR{0.85in}{disposed}         \\
         \hline
    \end{tabularx}
}

\newcommand{\FormHeader}{%
    \chead{\Large{\@title}}%
}

\fancypagestyle{nonum}{%
    \fancyhf{}
    \FormHeader%
    \lfoot{\@controlNumber}
    \rfoot{Rev.~\@revision}
}

\fancypagestyle{numall}{%
    \fancyhf{}
    \FormHeader%
    \lfoot{\@controlNumber, Page~\thepage~of~\pageref{LastPage}}
    \rfoot{Rev.~\@revision}
}

\fancypagestyle{formtotal}{%
    \fancyhf{}
    \FormHeader%
    \lfoot{%
        \begin{Form}
        \@controlNumber, Page~\thepage~of~\FormTextBoxU{0.2in}{totalpgs}
        \end{Form}
    }
    \rfoot{Rev.~\@revision}
}

\fancypagestyle{formall}{%
    \fancyhf{}
    \FormHeader%
    \lfoot{%
        \begin{Form}
        \@controlNumber, Page~\FormTextBoxU{0.2in}{pg\thepage}~of~\FormTextBoxU{0.2in}{totalpgs}
        \end{Form}
    }
    \rfoot{Rev.~\@revision}
}

\pagestyle{numall}

\newcommand{\controlNumber}[1]{%
    \def\@controlNumber{#1}%
}

\newcommand{\revision}[1]{%
    \def\@revision{#1}%
}


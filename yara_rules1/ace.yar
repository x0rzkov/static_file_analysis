rule CVE_2018_20250 : AceArchive UNACEV2_DLL_EXP
{
    meta:
        description = "Generic rule for hostile ACE archive using CVE-2018-20250"
        author = "xylitol@temari.fr"
        date = "2019-03-17"
        reference = "https://research.checkpoint.com/extracting-code-execution-from-winrar/"
        weight = 6
        tag = "attack.initial"
        // May only the challenge guide you
    strings:
        $string1 = "**ACE**" ascii wide
        $string2 = "*UNREGISTERED VERSION*" ascii wide
        // $hexstring1 = C:\C:\
        $hexstring1 = {?? 3A 5C ?? 3A 5C}
        // $hexstring2 = C:\C:C:..
        $hexstring2 = {?? 3A 5C ?? 3A ?? 3A 2E}
    condition:  
         $string1 at 7 and $string2 at 31 and 1 of ($hexstring*)
}

rule ACE_file {
    meta:
        author = "Florian Roth - based on Nick Hoffman' rule - Morphick Inc -- Modified by Lionel PRAT"
        description = "Looks for ACE Archives"
        date = "2015-09-09"
        weight = 5
        tag = "attack.initial_access,attack.t1189,attack.t1192,attack.t1193,attack.t1194"
    strings:
        $header = { 2a 2a 41 43 45 2a 2a }

    condition:
        $header at 7
}


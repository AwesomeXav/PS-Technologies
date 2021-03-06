New-ADFineGrainedPasswordPolicy -Name "Difficult" -Precedence 10 -MinPasswordLength 6 -ComplexityEnabled $false
New-ADFineGrainedPasswordPolicy -Name "Medium" -Precedence 50 -MinPasswordLength 5 -ComplexityEnabled $false
New-ADFineGrainedPasswordPolicy -Name "Simple" -Precedence 100 -MinPasswordLength 4 -ComplexityEnabled $false

Add-ADFineGrainedPasswordPolicySubject -Identity "Difficult" -Subjects "Domain Admins"
Add-ADFineGrainedPasswordPolicySubject -Identity "Simple" -Subjects "Domain Users"

Get-ADFineGrainedPasswordPolicy -Filter * | Sort-Object Precedence | Format-Table Name, minpasswordlength, appliesto -AutoSize

Get-ADFineGrainedPasswordPolicy -Filter * |
Set-ADFineGrainedPasswordPolicy -PasswordHistoryCount 0 -ReversibleEncryptionEnabled $false -MinPasswordAge 0

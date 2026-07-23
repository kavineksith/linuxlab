TITLE="Enforce a Password Aging Policy"
CATEGORY="security"
DIFFICULTY="advanced"
ENVIRON="both"
DESCRIPTION="Compliance requires the 'tempuser' contractor account to
have a strict password rotation policy: it must expire regularly, can't
be changed too frequently (to prevent history-cycling tricks), and
should warn the user before expiry."
OBJECTIVE="Using chage, configure the 'tempuser' account (created for
you) so that:
  1. Maximum password age is 30 days
  2. Minimum password age is 1 day
  3. Warning period before expiry is 7 days
Run 'lab check 03-security/006-password-policy' when done."

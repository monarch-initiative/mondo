# Generate token

1. In GitHub profile, click on settings in dropdown in upper right (click on your picture/avatar)
1. Click on developer settings
1. Click on personal access tokens
1. Generate token with the following options checked:
- workflow
- write:packages
- user 
  - read:user
  - user:email
  - user:follow
1. Copy the resulting token which is a long string of characters 
1. Go to Terminal:
1. Type:
`nano ~/.token`
1. Paste the token 
1. Save and exit: control O, enter, control X
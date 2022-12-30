# features
- users can register, login, logout of the system
- users can change their password
- support 3 user roles - admin, buyer, seller
- support image uploading for each shop items
- support lock_version to confirm atomic transactions
- datatables for every key tables
- show purchase_history, top_sellers
- certain pages are accessible to some roles only
- a set of system tests to test all the features above

# to run the app
`rails s`

# to run the system tests
all tests `rails test:system`

certain tests `rails test test/system/<test file name>`

-----

# note
System tests will automate a browser (e.g. clicking buttons, filling in forms), therefore requiring to work with a GUI application. If you're developing on ubuntu/WSL2.0, follow these steps
1. install the GPU driver for WSL2.0 and install a browser (e.g. chrome) [link](https://learn.microsoft.com/en-us/windows/wsl/tutorials/gui-apps#install-google-chrome-for-linux)
2. add these two lines in the ~/.bashrc file in your ubuntu

    `export DISPLAY=$(ip route list default | awk '{print $3}'):0`
    
    `export LIBGL_ALWAYS_INDIRECT=1`
    
3. download [xlaunch](https://sourceforge.net/projects/vcxsrv/) and `start no client` with `disable access control` options ON

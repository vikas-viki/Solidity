


    contract Dood_Wala{

        bool month_end = false;

        function send_money() public {

            if(month_end == true){

                your_wallet.send("Dood wala", 10);

            }

        }

    }




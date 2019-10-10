pragma solidity >=0.4.9 <0.6.0;
contract Election{

    struct Candidate {
        uint Id;
        string candidatename;
        string branch;
        string gender;
        string year;
        string email_id;
        string reg_id;
        uint vote_count;
    }

    mapping(address => bool) public voters;

    mapping (uint =>Candidate) public Candidates;

    uint public Candidate_count;
    event votedEvent (
        uint indexed _candidateId
    );

    function addCandidate(string memory _cand, string memory _branch, string memory _gender,
     string memory _email, string memory _year, string memory _reg_id) payable public{
        // var _cand = candidate[0];
        // var _branch = candidate[1];
        // var _gender = candidate[2];
        // var _email = candidate[3];
        // var _year = candidate[4];
        // var _reg_id = candidate[5];
        Candidates[Candidate_count] = Candidate(Candidate_count,_cand, _branch, _gender, _email, _year, _reg_id,0);
        Candidate_count ++;
    }

    function vote (uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender],"check voting done?");

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= Candidate_count, "validate candidate_id");

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        Candidates[_candidateId].vote_count++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }

    // constructor () public{
    //addCandidate("Aman");
    //addCandidate("Vishal");
    // addCandidate("demo", 20, "M", "address", "email", 10,"sangola", "maha", "bjp");
    // addCandidate("Vishwa", 20, "M", "address", "email", 10,"sangola", "maha", "bjp");
    // }
    // function addVote(uint _id) public{
    //     Candidate memory c =Candidates[_id];
    //     count_of_vote=c.vote_count;
    //     count_of_vote =count_of_vote+1;
    //     c.vote_count=count_of_vote;
    // }
}

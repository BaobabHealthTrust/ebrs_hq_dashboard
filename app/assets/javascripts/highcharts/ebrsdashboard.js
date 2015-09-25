 /* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(function () {

    //Table spline chanichani
    var tablecontent = {
                         "data":[
                                    {
                                        "district":"Balaka",
                                        "reported":[80,50, 60,40,79],
                                        "registered":[10,30, 13,30,10],
                                        "printed":250,
                                        "verified":230,
                                        "re_printed":220,
                                        "incomplete":150,
                                        "supected_duplicates":20,
                                        "amendement_request":10,
                                        "duration":
                                                    [
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:20:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:15:24",
                                                            "register_time":"Wed Mar 25 2015 10:22:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:20:24",
                                                            "register_time":"Wed Mar 25 2015 10:29:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:20:15"
                                                        }
                                                    ]
                                    },
                                        {
                                        "district":"Blantyre",
                                        "reported":[80,90, 60,23,79],
                                        "registered":[70,80, 50,23,60],
                                        "printed":250,
                                        "verified":230,
                                        "re_printed":220,
                                        "incomplete":150,
                                        "supected_duplicates":20,
                                        "amendement_request":10,
                                        "duration":
                                                    [
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:20:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:15:24",
                                                            "register_time":"Wed Mar 25 2015 10:22:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:20:24",
                                                            "register_time":"Wed Mar 25 2015 10:29:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:20:15"
                                                        }
                                                    ]
                                    },
                                        {
                                        "district":"Chikwawa",
                                        "reported":[80,50, 60,23,79],
                                        "registered":[75,45, 60,10,79],
                                        "printed":250,
                                        "verified":230,
                                        "re_printed":220,
                                        "incomplete":150,
                                        "supected_duplicates":20,
                                        "amendement_request":10,
                                        "duration":
                                                    [
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:20:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:15:24",
                                                            "register_time":"Wed Mar 25 2015 10:22:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:20:24",
                                                            "register_time":"Wed Mar 25 2015 10:29:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:20:15"
                                                        }
                                                    ]
                                    },
                                    {
                                        "district":"Chiradzulu",
                                        "reported":[20,40, 90,30,50],
                                        "registered":[20,25, 90,30,30],
                                        "printed":130,
                                        "verified":120,
                                        "re_printed":100,
                                        "incomplete":80,
                                        "supected_duplicates":15,
                                        "amendement_request":8,
                                        "duration":
                                                [
                                                    {
                                                        "report_time":"Wed Mar 25 2015 09:56:24",
                                                        "register_time":"Wed Mar 25 2015 10:20:15"
                                                    },
                                                    {
                                                        "report_time":"Wed Mar 25 2015 10:15:24",
                                                        "register_time":"Wed Mar 25 2015 10:22:15"
                                                    },
                                                    {
                                                        "report_time":"Wed Mar 25 2015 10:20:24",
                                                        "register_time":"Wed Mar 25 2015 10:29:15"
                                                    },
                                                    {
                                                        "report_time":"Wed Mar 25 2015 09:56:24",
                                                        "register_time":"Wed Mar 25 2015 10:20:15"
                                                    }
                                                ]
                                    },

                                      {
                                        "district":"Chipita",
                                        "reported":[20,40, 90,30,50],
                                        "registered":[20,25, 90,30,30],
                                        "printed":130,
                                        "verified":120,
                                        "re_printed":100,
                                        "incomplete":80,
                                        "supected_duplicates":15,
                                        "amendement_request":8,
                                        "duration":
                                                [
                                                    {
                                                        "report_time":"Wed Mar 25 2015 09:56:24",
                                                        "register_time":"Wed Mar 25 2015 10:20:15"
                                                    },
                                                    {
                                                        "report_time":"Wed Mar 25 2015 10:15:24",
                                                        "register_time":"Wed Mar 25 2015 10:22:15"
                                                    },
                                                    {
                                                        "report_time":"Wed Mar 25 2015 10:20:24",
                                                        "register_time":"Wed Mar 25 2015 10:29:15"
                                                    },
                                                    {
                                                        "report_time":"Wed Mar 25 2015 09:56:24",
                                                        "register_time":"Wed Mar 25 2015 10:20:15"
                                                    }
                                                ]
                                    },

                                      {
                                        "district":"Dedza",
                                        "reported":[20,40, 90,30,50],
                                        "registered":[20,25, 90,30,30],
                                        "printed":130,
                                        "verified":120,
                                        "re_printed":100,
                                        "incomplete":80,
                                        "supected_duplicates":15,
                                        "amendement_request":8,
                                        "duration":
                                                [
                                                    {
                                                        "report_time":"Wed Mar 25 2015 09:56:24",
                                                        "register_time":"Wed Mar 25 2015 10:20:15"
                                                    },
                                                    {
                                                        "report_time":"Wed Mar 25 2015 10:15:24",
                                                        "register_time":"Wed Mar 25 2015 10:22:15"
                                                    },
                                                    {
                                                        "report_time":"Wed Mar 25 2015 10:20:24",
                                                        "register_time":"Wed Mar 25 2015 10:29:15"
                                                    },
                                                    {
                                                        "report_time":"Wed Mar 25 2015 09:56:24",
                                                        "register_time":"Wed Mar 25 2015 10:20:15"
                                                    }
                                                ]
                                    },
                                    {
                                        "district":"Dowa",
                                        "reported":[53,78, 20,100,43],
                                        "registered":[53,50, 20,100,43],
                                        "printed":130,
                                        "verified":120,
                                        "re_printed":100,
                                        "incomplete":80,
                                        "supected_duplicates":15,
                                        "amendement_request":8,
                                        "duration":
                                                    [
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:20:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:15:24",
                                                            "register_time":"Wed Mar 25 2015 10:22:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:20:24",
                                                            "register_time":"Wed Mar 25 2015 10:25:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:12:15"
                                                        }
                                                    ]
                                    }
                                    ,
                                     {
                                        "district":"Karonga",
                                        "reported":[53,78, 20,100,43],
                                        "registered":[53,50, 20,100,43],
                                        "printed":130,
                                        "verified":120,
                                        "re_printed":100,
                                        "incomplete":80,
                                        "supected_duplicates":15,
                                        "amendement_request":8,
                                        "duration":
                                                    [
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:20:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:15:24",
                                                            "register_time":"Wed Mar 25 2015 10:22:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:20:24",
                                                            "register_time":"Wed Mar 25 2015 10:25:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:12:15"
                                                        }
                                                    ]
                                    },
                                    {
                                        "district":"Kasungu",
                                        "reported":[80,50, 60,40,79],
                                        "registered":[10,30, 13,30,10],
                                        "printed":250,
                                        "verified":230,
                                        "re_printed":220,
                                        "incomplete":150,
                                        "supected_duplicates":20,
                                        "amendement_request":10,
                                        "duration":
                                                    [
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:20:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:15:24",
                                                            "register_time":"Wed Mar 25 2015 10:22:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:20:24",
                                                            "register_time":"Wed Mar 25 2015 10:29:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:20:15"
                                                        }
                                                    ]
                                    },
                                        {
                                        "district":"Likoma",
                                        "reported":[80,90, 60,23,79],
                                        "registered":[70,80, 50,23,60],
                                        "printed":250,
                                        "verified":230,
                                        "re_printed":220,
                                        "incomplete":150,
                                        "supected_duplicates":20,
                                        "amendement_request":10,
                                        "duration":
                                                    [
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:20:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:15:24",
                                                            "register_time":"Wed Mar 25 2015 10:22:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:20:24",
                                                            "register_time":"Wed Mar 25 2015 10:29:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:20:15"
                                                        }
                                                    ]
                                    },
                                        {
                                        "district":"Lilongwe",
                                        "reported":[80,50, 60,23,79],
                                        "registered":[75,45, 60,10,79],
                                        "printed":250,
                                        "verified":230,
                                        "re_printed":220,
                                        "incomplete":150,
                                        "supected_duplicates":20,
                                        "amendement_request":10,
                                        "duration":
                                                    [
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:20:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:15:24",
                                                            "register_time":"Wed Mar 25 2015 10:22:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:20:24",
                                                            "register_time":"Wed Mar 25 2015 10:29:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:20:15"
                                                        }
                                                    ]
                                    },
                                    {
                                        "district":"Machinga",
                                        "reported":[20,40, 90,30,50],
                                        "registered":[20,25, 90,30,30],
                                        "printed":130,
                                        "verified":120,
                                        "re_printed":100,
                                        "incomplete":80,
                                        "supected_duplicates":15,
                                        "amendement_request":8,
                                        "duration":
                                                [
                                                    {
                                                        "report_time":"Wed Mar 25 2015 09:56:24",
                                                        "register_time":"Wed Mar 25 2015 10:20:15"
                                                    },
                                                    {
                                                        "report_time":"Wed Mar 25 2015 10:15:24",
                                                        "register_time":"Wed Mar 25 2015 10:22:15"
                                                    },
                                                    {
                                                        "report_time":"Wed Mar 25 2015 10:20:24",
                                                        "register_time":"Wed Mar 25 2015 10:29:15"
                                                    },
                                                    {
                                                        "report_time":"Wed Mar 25 2015 09:56:24",
                                                        "register_time":"Wed Mar 25 2015 10:20:15"
                                                    }
                                                ]
                                    },

                                      {
                                        "district":"Mangochi",
                                        "reported":[20,40, 90,30,50],
                                        "registered":[20,25, 90,30,30],
                                        "printed":130,
                                        "verified":120,
                                        "re_printed":100,
                                        "incomplete":80,
                                        "supected_duplicates":15,
                                        "amendement_request":8,
                                        "duration":
                                                [
                                                    {
                                                        "report_time":"Wed Mar 25 2015 09:56:24",
                                                        "register_time":"Wed Mar 25 2015 10:20:15"
                                                    },
                                                    {
                                                        "report_time":"Wed Mar 25 2015 10:15:24",
                                                        "register_time":"Wed Mar 25 2015 10:22:15"
                                                    },
                                                    {
                                                        "report_time":"Wed Mar 25 2015 10:20:24",
                                                        "register_time":"Wed Mar 25 2015 10:29:15"
                                                    },
                                                    {
                                                        "report_time":"Wed Mar 25 2015 09:56:24",
                                                        "register_time":"Wed Mar 25 2015 10:20:15"
                                                    }
                                                ]
                                    },

                                      {
                                        "district":"Mchinji",
                                        "reported":[20,40, 90,30,50],
                                        "registered":[20,25, 90,30,30],
                                        "printed":130,
                                        "verified":120,
                                        "re_printed":100,
                                        "incomplete":80,
                                        "supected_duplicates":15,
                                        "amendement_request":8,
                                        "duration":
                                                [
                                                    {
                                                        "report_time":"Wed Mar 25 2015 09:56:24",
                                                        "register_time":"Wed Mar 25 2015 10:20:15"
                                                    },
                                                    {
                                                        "report_time":"Wed Mar 25 2015 10:15:24",
                                                        "register_time":"Wed Mar 25 2015 10:22:15"
                                                    },
                                                    {
                                                        "report_time":"Wed Mar 25 2015 10:20:24",
                                                        "register_time":"Wed Mar 25 2015 10:29:15"
                                                    },
                                                    {
                                                        "report_time":"Wed Mar 25 2015 09:56:24",
                                                        "register_time":"Wed Mar 25 2015 10:20:15"
                                                    }
                                                ]
                                    },
                                    {
                                        "district":"Mulanje",
                                        "reported":[53,78, 20,100,43],
                                        "registered":[53,50, 20,100,43],
                                        "printed":130,
                                        "verified":120,
                                        "re_printed":100,
                                        "incomplete":80,
                                        "supected_duplicates":15,
                                        "amendement_request":8,
                                        "duration":
                                                    [
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:20:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:15:24",
                                                            "register_time":"Wed Mar 25 2015 10:22:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:20:24",
                                                            "register_time":"Wed Mar 25 2015 10:25:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:12:15"
                                                        }
                                                    ]
                                    }
                                    ,
                                     {
                                        "district":"Mwanza",
                                        "reported":[53,78, 20,100,43],
                                        "registered":[53,50, 20,100,43],
                                        "printed":130,
                                        "verified":120,
                                        "re_printed":100,
                                        "incomplete":80,
                                        "supected_duplicates":15,
                                        "amendement_request":8,
                                        "duration":
                                                    [
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:20:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:15:24",
                                                            "register_time":"Wed Mar 25 2015 10:22:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:20:24",
                                                            "register_time":"Wed Mar 25 2015 10:25:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:12:15"
                                                        }
                                                    ]
                                    },{
                                        "district":"Mzimba",
                                        "reported":[80,50, 60,40,79],
                                        "registered":[10,30, 13,30,10],
                                        "printed":250,
                                        "verified":230,
                                        "re_printed":220,
                                        "incomplete":150,
                                        "supected_duplicates":20,
                                        "amendement_request":10,
                                        "duration":
                                                    [
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:20:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:15:24",
                                                            "register_time":"Wed Mar 25 2015 10:22:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:20:24",
                                                            "register_time":"Wed Mar 25 2015 10:29:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:20:15"
                                                        }
                                                    ]
                                    },
                                        {
                                        "district":"Neno",
                                        "reported":[80,90, 60,23,79],
                                        "registered":[70,80, 50,23,60],
                                        "printed":250,
                                        "verified":230,
                                        "re_printed":220,
                                        "incomplete":150,
                                        "supected_duplicates":20,
                                        "amendement_request":10,
                                        "duration":
                                                    [
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:20:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:15:24",
                                                            "register_time":"Wed Mar 25 2015 10:22:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:20:24",
                                                            "register_time":"Wed Mar 25 2015 10:29:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:20:15"
                                                        }
                                                    ]
                                    },
                                        {
                                        "district":"Nkhata Bay",
                                        "reported":[80,50, 60,23,79],
                                        "registered":[75,45, 60,10,79],
                                        "printed":250,
                                        "verified":230,
                                        "re_printed":220,
                                        "incomplete":150,
                                        "supected_duplicates":20,
                                        "amendement_request":10,
                                        "duration":
                                                    [
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:20:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:15:24",
                                                            "register_time":"Wed Mar 25 2015 10:22:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:20:24",
                                                            "register_time":"Wed Mar 25 2015 10:29:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:20:15"
                                                        }
                                                    ]
                                    },
                                    {
                                        "district":"Nkhotakota",
                                        "reported":[20,40, 90,30,50],
                                        "registered":[20,25, 90,30,30],
                                        "printed":130,
                                        "verified":120,
                                        "re_printed":100,
                                        "incomplete":80,
                                        "supected_duplicates":15,
                                        "amendement_request":8,
                                        "duration":
                                                [
                                                    {
                                                        "report_time":"Wed Mar 25 2015 09:56:24",
                                                        "register_time":"Wed Mar 25 2015 10:20:15"
                                                    },
                                                    {
                                                        "report_time":"Wed Mar 25 2015 10:15:24",
                                                        "register_time":"Wed Mar 25 2015 10:22:15"
                                                    },
                                                    {
                                                        "report_time":"Wed Mar 25 2015 10:20:24",
                                                        "register_time":"Wed Mar 25 2015 10:29:15"
                                                    },
                                                    {
                                                        "report_time":"Wed Mar 25 2015 09:56:24",
                                                        "register_time":"Wed Mar 25 2015 10:20:15"
                                                    }
                                                ]
                                    },

                                      {
                                        "district":"Nsanje",
                                        "reported":[20,40, 90,30,50],
                                        "registered":[20,25, 90,30,30],
                                        "printed":130,
                                        "verified":120,
                                        "re_printed":100,
                                        "incomplete":80,
                                        "supected_duplicates":15,
                                        "amendement_request":8,
                                        "duration":
                                                [
                                                    {
                                                        "report_time":"Wed Mar 25 2015 09:56:24",
                                                        "register_time":"Wed Mar 25 2015 10:20:15"
                                                    },
                                                    {
                                                        "report_time":"Wed Mar 25 2015 10:15:24",
                                                        "register_time":"Wed Mar 25 2015 10:22:15"
                                                    },
                                                    {
                                                        "report_time":"Wed Mar 25 2015 10:20:24",
                                                        "register_time":"Wed Mar 25 2015 10:29:15"
                                                    },
                                                    {
                                                        "report_time":"Wed Mar 25 2015 09:56:24",
                                                        "register_time":"Wed Mar 25 2015 10:20:15"
                                                    }
                                                ]
                                    },

                                      {
                                        "district":"Ntcheu",
                                        "reported":[20,40, 90,30,50],
                                        "registered":[20,25, 90,30,30],
                                        "printed":130,
                                        "verified":120,
                                        "re_printed":100,
                                        "incomplete":80,
                                        "supected_duplicates":15,
                                        "amendement_request":8,
                                        "duration":
                                                [
                                                    {
                                                        "report_time":"Wed Mar 25 2015 09:56:24",
                                                        "register_time":"Wed Mar 25 2015 10:20:15"
                                                    },
                                                    {
                                                        "report_time":"Wed Mar 25 2015 10:15:24",
                                                        "register_time":"Wed Mar 25 2015 10:22:15"
                                                    },
                                                    {
                                                        "report_time":"Wed Mar 25 2015 10:20:24",
                                                        "register_time":"Wed Mar 25 2015 10:29:15"
                                                    },
                                                    {
                                                        "report_time":"Wed Mar 25 2015 09:56:24",
                                                        "register_time":"Wed Mar 25 2015 10:20:15"
                                                    }
                                                ]
                                    },
                                    {
                                        "district":"Ntchisi",
                                        "reported":[53,78, 20,100,43],
                                        "registered":[53,50, 20,100,43],
                                        "printed":130,
                                        "verified":120,
                                        "re_printed":100,
                                        "incomplete":80,
                                        "supected_duplicates":15,
                                        "amendement_request":8,
                                        "duration":
                                                    [
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:20:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:15:24",
                                                            "register_time":"Wed Mar 25 2015 10:22:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:20:24",
                                                            "register_time":"Wed Mar 25 2015 10:25:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:12:15"
                                                        }
                                                    ]
                                    }
                                    ,
                                     {
                                        "district":"Phalombe",
                                        "reported":[53,78, 20,100,43],
                                        "registered":[53,50, 20,100,43],
                                        "printed":130,
                                        "verified":120,
                                        "re_printed":100,
                                        "incomplete":80,
                                        "supected_duplicates":15,
                                        "amendement_request":8,
                                        "duration":
                                                    [
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:20:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:15:24",
                                                            "register_time":"Wed Mar 25 2015 10:22:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:20:24",
                                                            "register_time":"Wed Mar 25 2015 10:25:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:12:15"
                                                        }
                                                    ]
                                    },
                                    {
                                        "district":"Rumphi",
                                        "reported":[53,78, 20,100,43],
                                        "registered":[53,50, 20,100,43],
                                        "printed":130,
                                        "verified":120,
                                        "re_printed":100,
                                        "incomplete":80,
                                        "supected_duplicates":15,
                                        "amendement_request":8,
                                        "duration":
                                                    [
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:20:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:15:24",
                                                            "register_time":"Wed Mar 25 2015 10:22:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:20:24",
                                                            "register_time":"Wed Mar 25 2015 10:25:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:12:15"
                                                        }
                                                    ]
                                    },
                                    {
                                        "district":"Salima",
                                        "reported":[53,78, 20,100,43],
                                        "registered":[53,50, 20,100,43],
                                        "printed":130,
                                        "verified":120,
                                        "re_printed":100,
                                        "incomplete":80,
                                        "supected_duplicates":15,
                                        "amendement_request":8,
                                        "duration":
                                                    [
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:20:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:15:24",
                                                            "register_time":"Wed Mar 25 2015 10:22:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:20:24",
                                                            "register_time":"Wed Mar 25 2015 10:25:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:12:15"
                                                        }
                                                    ]
                                    },
                                    {
                                        "district":"Thyolo",
                                        "reported":[53,78, 20,100,43],
                                        "registered":[53,50, 20,100,43],
                                        "printed":130,
                                        "verified":120,
                                        "re_printed":100,
                                        "incomplete":80,
                                        "supected_duplicates":15,
                                        "amendement_request":8,
                                        "duration":
                                                    [
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:20:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:15:24",
                                                            "register_time":"Wed Mar 25 2015 10:22:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:20:24",
                                                            "register_time":"Wed Mar 25 2015 10:25:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:12:15"
                                                        }
                                                    ]
                                    },
                                    {
                                        "district":"Zomba",
                                        "reported":[53,78, 20,100,43],
                                        "registered":[53,50, 20,100,43],
                                        "printed":130,
                                        "verified":120,
                                        "re_printed":100,
                                        "incomplete":80,
                                        "supected_duplicates":15,
                                        "amendement_request":8,
                                        "duration":
                                                    [
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:20:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:15:24",
                                                            "register_time":"Wed Mar 25 2015 10:22:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 10:20:24",
                                                            "register_time":"Wed Mar 25 2015 10:25:15"
                                                        },
                                                        {
                                                            "report_time":"Wed Mar 25 2015 09:56:24",
                                                            "register_time":"Wed Mar 25 2015 10:12:15"
                                                        }
                                                    ]
                                    }
                                ]
                            }

        //Initializing Aggregates
        var monthly_reported_aggregate=0;
        var annual_reported_aggregate=0;

        var monthly_printed_aggregate =0;
        var annual_printed_aggregate =0;

        var monthly_verified_aggregate =0;
        var annual_verified_aggregate =0;

        var monthly_re_printed_aggregate =0;
        var annual_re_printed_aggregate =0;

        var monthly_icomplete_aggregate =0;
        var annual_incomple_aggregate =0;

        var monthly_supected_duplicates_aggregate =0;
        var annual_supected_duplicates_aggregate =0;

        var monthly_amendement_request_aggregate =0;
        var annual_amendement_request_aggregate =0;

        var ever_registered = 0;
        var ever_reported = 0;

        var average_sum = 0;
        var num_of_districts = 0;
        for (var i in tablecontent.data){


           var graph_id ="graph"+i;
          // console.log(graph_id);

            var row = "<tr><td align='left'>"+tablecontent.data[i].district+"</td><td align='center' id =\'"+graph_id+"";
                var district_total_reported =0;
                for (var j in tablecontent.data[i].reported){
                        district_total_reported = district_total_reported + parseInt(tablecontent.data[i].reported[j]);

                        //row = row + tablecontent.data[i].reported[j] +",  ";
                }

                var district_total_registered =0;
                for (var j in tablecontent.data[i].registered){
                        district_total_registered = district_total_registered + parseInt(tablecontent.data[i].registered[j]);

                        //row = row + tablecontent.data[i].reported[j] +",  ";
                }

                //row = row.slice(0,row.lastIndexOf(","));

                //Computing Total Average
                var average = average_interval(tablecontent.data[i].duration);
                average_sum = average_sum + average;
                num_of_districts = parseInt(i) + 1;


                //
                row = row+"\'/><td>"+district_total_reported+"</td><td>"+district_total_registered+"</td><td >"+average+"</td><td id= \'"+i+"\'>"+"BarGraph"+"</td>";
                 if(i==0){

                    row = row+"<td colspan='5' rowspan=2 style='font-size: 16px; font-weight: bold; padding: 0.5em;'>National % Aggregates</td>";
                   
                    }
                   if(i == 2){
                      row = row +" <th colspan='6' rowspan='28' valign='top'><div id='barchart_right'><table><thead><tr><th>#</th><th>Category</th><th></th><th>Current month % of registration</th><th></th><th>Current year % of registration</th></tr></thead><tbody><tr><td>1</td><th>reported</th><td id='monthly_reported_percent'></td><td id='monthly_reported'></td><td id='annual_reported_percent'></td><td id='annual_reported'></td></tr><tr><td>2</td><th>Printed</th><td id='monthly_printed_percent'></td><td id='monthly_printed'></td><td id='annual_printed_percent'></td><td id='annual_printed'></td></tr><tr><td>3</td><th>Verified</th><td id='monthly_verified_percent'></td><td id='monthly_verified'></td><td id='annual_verified_percent'></td><td id='annual_verified'></td></tr><tr><td>4</td><th>Reprinted</th><td id='monthly_re_printed_percent'></td><td id='monthly_re_printed'></td><td id='annual_re_printed_percent'></td><td id='annual_re_printed'></td></tr> <tr><td>5</td><th>Incomplete</th><td id='monthly_incomplete_percent'></td><td id='monthly_incomplete'></td><td id='annual_incomplete_percent'></td><td id='annual_incomplete'></td></tr><tr><td>6</td><th>Suspected Duplicates</th><td id='monthly_supected_duplicates_percent'></td><td id='monthly_supected_duplicates'></td><td id='annual_supected_duplicates_percent'></td><td id='annual_supected_duplicates'></td></tr><tr><td>7</td><th>Amendement Requests</th><td id='monthly_amendement_percent'></td><td id='monthly_amendement'></td><td id='annual_amendement_percent'></td><td id='annual_amendement'></td></tr></tbody></table></div><div id='piechart'></div></th>";
                    }

                //console.log(row);
                $("#main").append(row);
               
                ever_registered = ever_registered + district_total_registered;

                //Summing aggregates
                monthly_reported_aggregate = monthly_reported_aggregate + district_total_reported;

                monthly_printed_aggregate = monthly_printed_aggregate + tablecontent.data[i].printed;

                monthly_verified_aggregate = monthly_verified_aggregate +  tablecontent.data[i].verified;

                monthly_re_printed_aggregate = monthly_re_printed_aggregate + tablecontent.data[i].re_printed;

                monthly_icomplete_aggregate = monthly_icomplete_aggregate + tablecontent.data[i].incomplete;

                
                monthly_supected_duplicates_aggregate = monthly_supected_duplicates_aggregate + tablecontent.data[i].supected_duplicates

                monthly_amendement_request_aggregate = monthly_amendement_request_aggregate + tablecontent.data[i].amendement_request;



                var registered = (district_total_registered/district_total_reported) * 100;
                drawMiniGraph(graph_id, null, tablecontent.data[i].reported);
                drawbarchartforapproval(i,registered);


        }

            var totals = "  <tr><th align='left'>Total</th><td>&nbsp;</td><td>"+ monthly_reported_aggregate +"</td><td>"+ever_registered+"</td><td>"+(average_sum/num_of_districts).toFixed(2)+"</td><td id='total'></td></tr>";
            //console.log("average_sum"+average_sum+" "+num_of_districts);
            $("#main").append(totals);

            drawbarchartforapproval("total",(ever_registered/monthly_reported_aggregate)*100);

            //Drawing Bar Charts
            aggregates("#monthly_reported", monthly_reported_aggregate, monthly_reported_aggregate);
            aggregates("#annual_reported", monthly_reported_aggregate, monthly_reported_aggregate);


            
            aggregates("#monthly_printed",monthly_printed_aggregate,monthly_reported_aggregate);
             aggregates("#annual_printed",monthly_printed_aggregate,monthly_reported_aggregate);


            aggregates("#monthly_verified",monthly_verified_aggregate,monthly_reported_aggregate);
            aggregates("#annual_verified",monthly_verified_aggregate,monthly_reported_aggregate);

          
            aggregates("#monthly_re_printed",monthly_re_printed_aggregate,monthly_reported_aggregate);
            aggregates("#annual_re_printed",monthly_re_printed_aggregate,monthly_reported_aggregate);


            
             aggregates("#monthly_incomplete",monthly_icomplete_aggregate,monthly_reported_aggregate);
             aggregates("#annual_incomplete",monthly_icomplete_aggregate,monthly_reported_aggregate);

            
             aggregates("#monthly_supected_duplicates",monthly_supected_duplicates_aggregate,monthly_reported_aggregate);
              aggregates("#annual_supected_duplicates",monthly_supected_duplicates_aggregate,monthly_reported_aggregate);


            
             aggregates("#monthly_amendement",monthly_amendement_request_aggregate,monthly_reported_aggregate);
             aggregates("#annual_amendement",monthly_amendement_request_aggregate,monthly_reported_aggregate);
               

    //$("#barchart table td ").css({"height":"2em","min-width":"5em"});
    function aggregates(id, value, reported){
        var percent = (value/reported) *100;
        var perId = id+"_percent";
        //console.log(perId);
        html = value + " ("+ parseInt(percent)+"%)";
       // console.log("Bar"+html);
        $(perId).html(html);
        drawbarchart(id,percent);
    }


    //Drawing Pie Chart
    ever_reported = monthly_reported_aggregate;

    //console.log("Printed Monthly"+monthly_printed_aggregate+"\n"+"Ever registered"+ever_registered+"\n"+ever_reported);
    drawPieChart(ever_registered, ever_reported,monthly_printed_aggregate);

});


 //Fuction For Average Time to Register
 function average_interval (duration){
        var total_interval =0;

        for (var i in duration) {
            var report = new Date(duration[i].report_time).getTime();
            var register = new Date(duration[i].register_time).getTime();
            total_interval = total_interval + (register - report);
        };

        return total_interval/(duration.length * 1000 * 60);
}

function drawMiniGraph(id, reported, registed){

     var array = [30,45,80,25,95];
    $('#'+id).highcharts({
        chart:{
            spacingBottom: 0,
            spacingTop: 0,
            spacingLeft: 0,
            spacingRight: 0,
            width: 200,
            height: 20 ,
            margin: [0, 0, 0, 0]
        },
        title: {
            text: '',
            //center
        },
        subtitle: {
            text: ''
        },
        xAxis: {
            categories: ['Week 1', 'Week 2', 'Week 3', 'Week 4', 'Week 5'],
            labels: {
                     enabled: false
            },
            title:{
                    enabled:false
            },
            axis:{
                    enabled:false
            }

        },
        yAxis: {
            title: {
                text: ''
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }],
             labels: {
                     enabled: false
            },
            title:{
                    enabled:false
            },
            axis:{
                    enabled:false
            }
            ,
            min: 0
        },
        legend: {
            enabled:false
        }
         ,
        tooltip: {
            enabled: false
        }
        ,
        series: [{
            name: 'Reported',
            
            color : '#729fcf',
            data: registed
        }, {
            name: 'reported',
            color: '#5788a4'
            ,
            data: array
        }]
    });

}


 //Pie Chart
 $(function () {

    
});

//Bar Charts



 //Draw Bar charts
 function drawbarchart(container,percent){
    //var container = '#container';
                $(function () {
                $(container).highcharts({
                    chart: {
                        type: 'bar',
                        spacingBottom: 0.5,
                        spacingTop: 0.5,
                        spacingLeft: 0.5,
                        spacingRight: 0.5,
                        width: null,
                        height: null
                    },
                    title: {
                        text: ''
                    },
                    xAxis: {
                        //categories: ['Africa', 'America', 'Asia', 'Europe', 'Oceania']
                        labels: {
                            enabled: false
                        }

                    },
                    yAxis: {
                        min: 0,
                        labels: {
                            enabled: false
                        },
                        title:{
                            enabled:false
                        },
                        axis:{
                            enabled:false
                        },
                        min: 0,
                        max: 100

                    },
                    legend: {
                                enabled: false
                     }
                    ,
                    tooltip: {
                        enabled: false
                    },
                    series: [{
                        name: 'reported',
                        colors: '#729fcf',
                        data: [percent],
                        pointPadding: -2
                    }]
                });
            });
    }



    //Approval Bar Char fuction
    function drawbarchartforapproval(id,registered){
        $(function () {
                $('#'+id).highcharts({

                    chart:{
                        type:"bar",
                        spacingBottom: 0,
                        spacingTop: 0,
                        spacingLeft: 0,
                        spacingRight: 0,
                        width: 170,
                        height: null,
                        margin: [0, 0, 0, 0]

                    },
                    title: {
                            text: ''
                    }
                    ,
                    xAxis:{
                          labels: {
                            enabled: false
                        }
                    },
                    yAxis:{
                        labels: {
                            enabled: false
                        },
                        title:{
                            enabled:false
                        },
                        axis:{
                            enabled:false
                        },
                        min: 0,
                        max: 100

                    },

                    legend: {
                                enabled: false
                     }
                    ,
                    
                    tooltip: {
                            enabled: false
                    },
                    plotOptions: {
                            bar: {
                                grouping: false,
                                shadow: false,
                                borderWidth: 0
                            }
                        }
                    ,
                     series: [{
                                    name: 'reported ',
                                    color: '#cfe7f5',
                                    data: [100],
                                    pointPadding: -0.09
                                },
                                {
                                    name: 'approve',
                                    color:'#729fcf',
                                    data : [registered],
                                    pointPadding: 0.25
                                }  
                            ]

                });
        });
    }



function drawPieChart(ever_registered, ever_reported,ever_printed){

            var total = ever_registered + ever_reported + ever_printed;
            ever_registered_percent = (ever_registered/total)*100;
           
            ever_registered_percent = ever_registered_percent.toFixed(1);

            ever_printed_percent = (ever_printed/total) * 100;
            ever_printed_percent = ever_printed_percent.toFixed(1);
          
            var ever_reported_percent = (100 - ever_registered_percent - ever_printed_percent).toFixed(1);
            // Make monochrome colors and set them as default for all pies
            Highcharts.getOptions().plotOptions.pie.colors = (function () {
                var colors = [],
                    base = Highcharts.getOptions().colors[0],
                    i;

                for (i = 0; i < 10; i += 1) {
                    // Start out with a darkened base color (negative brighten), and end
                    // up with a much brighter color
                    colors.push(Highcharts.Color(base).brighten((i - 3) / 7).get());
                }
                return colors;
            }());

            // Build the chart
            $('#piechart').highcharts({
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: null,
                    plotShadow: false,
                    type: 'pie'
                },
                title: {
                    text: '<font style="color:#004586;font-size:0.75em;font-weight:bold">National Total registered vs Total reported</font>',
                },
                tooltip: {
                    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                },
                plotOptions: {
                    pie: {
                        allowPointSelect: true,
                        cursor: 'pointer',
                        dataLabels: {
                            enabled: true,
                            format: '<b>{point.name}</b>:<br> {point.percentage:.1f} %',
                            style: {
                                color:[ (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black']
                            }
                        }
                    }
                },
                series: [{
                    name: "People",

                    data: [
                        
                        {
                            name: "Registered",
                            color:'#729fcf',
                            y: parseFloat(ever_registered_percent)
                        },
                        {
                            name: "Reported",
                            color: '#cfe7f5', 
                            y: parseFloat(ever_reported_percent)
                        },
                        {
                            name: "Printed",
                            y:parseFloat(ever_printed_percent)
                        }

                    ]
                }]
            });

}
$(document).ready(
    function(){
     
        $("#main tr td:nth-child(1)").css({"font-weight":"bold", "font-size":"0.85em"});
        $("#barchart th:even,td:even").css({"width":"7%"});
        $("#barchart th:nth-child(1),td:nth-child(1)").css("width","7%");
        $("#barchart th:nth-child(2),td:nth-child(2)").css({"width":"12%"});
        $("#barchart th:nth-child(3),td:nth-child(3)").css({"text-align":"center"});
        $("#barchart th:nth-child(4),td:nth-child(4)").css({"text-align":"center"});
        $("#barchart th:nth-child(5),td:nth-child(5)").css({"text-align":"center"});

    }
);
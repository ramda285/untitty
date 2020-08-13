<<<<<<< HEAD
﻿using UnityEngine;
=======
﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;
>>>>>>> origin/master

public class ButtonScript : MonoBehaviour
{
    public bool button;
    // Start is called before the first frame update
    void Start()
    {
        button = false;
    }

    // Update is called once per frame
    public void OnClick()
    {
        button = true;
    }
}

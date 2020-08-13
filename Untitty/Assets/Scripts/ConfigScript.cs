using UnityEngine;
using UnityEngine.UI;

public class ConfigScript : MonoBehaviour
{
    // Start is called before the first frame update
    bool dl;
    public GameObject modoru, yawai, hutsu, katai, tyuto;
    public GameObject geji;
    void Start()
    {
        dl = false;
    }

    // Update is called once per frame
    void Update()
    {
        ComonScript.Getting(dl,0);
        ComonScript.kando = geji.GetComponent<Slider>().value;
        if (modoru.GetComponent<ButtonScript>().button == true){
            dl = true;
        }
        if (yawai.GetComponent<ButtonScript>().button == true){
            Zenkeshi();
            ComonScript.nanid = 0;
            yawai.GetComponent<Text>().color = Color.red;
        }else if (hutsu.GetComponent<ButtonScript>().button == true){
            Zenkeshi();
            ComonScript.nanid = 1;
            hutsu.GetComponent<Text>().color = Color.red;
        }else if (katai.GetComponent<ButtonScript>().button == true){
            Zenkeshi();
            ComonScript.nanid = 2;
            katai.GetComponent<Text>().color = Color.red;
        }
        if (tyuto.GetComponent<ButtonScript>().button == true){
            ComonScript.Getting(true,6);
            ComonScript.Getting(true,6);
        }
    }

    void Zenkeshi(){
        yawai.GetComponent<ButtonScript>().button = false;
        yawai.GetComponent<Text>().color = new Color(128f/255f,84f/255f,6f/255f);
        hutsu.GetComponent<ButtonScript>().button = false;
        hutsu.GetComponent<Text>().color = new Color(128f/255f,84f/255f,6f/255f);
        katai.GetComponent<ButtonScript>().button = false;
        katai.GetComponent<Text>().color = new Color(128f/255f,84f/255f,6f/255f);
    }
}

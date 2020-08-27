using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Hover : MonoBehaviour
{
    public Material firstMaterial;
    public Material secondMaterial;

    void OnMouseOver()
    {
        GetComponent<Renderer>().material = secondMaterial; // Show second material when mouse hovers over object
    }

    void OnMouseExit()
    {
        GetComponent<Renderer>().material = firstMaterial;  // Show first material when mouse is not hovering over object
    }
}

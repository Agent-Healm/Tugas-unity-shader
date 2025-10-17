using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Follow : MonoBehaviour
{
    public Material characterMarkerMat;

    // Use this for initialization
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {
        Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
        RaycastHit hit;

        if (Physics.Raycast(ray, out hit))
        {
            Vector3 mousePos = hit.point;

            Vector3 dir = hit.point - transform.position;
            dir.y = 0;

            float speed = 0.1f;
            if (dir.magnitude > speed)
            {
                dir.Normalize();
                transform.Translate(dir * speed);
            }

            Vector3 spherePos = transform.position;
            spherePos.y = 0;
            //characterMarkerMat.SetVector("Vector3_337113A", spherePos);
            characterMarkerMat.SetVector("_pos", spherePos);
        }
    }
}
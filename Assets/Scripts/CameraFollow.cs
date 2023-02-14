using UnityEngine;

public class CameraFollow : MonoBehaviour
{
    [SerializeField] private Transform player;
    [SerializeField] private float followSpeed;

    void FixedUpdate()
    {
        transform.position = Vector3.Lerp(transform.position, 
            new Vector3(player.position.x, transform.position.y, player.position.z), Time.fixedDeltaTime * followSpeed);
    }
}

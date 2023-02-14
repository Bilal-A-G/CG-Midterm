using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShipMovement : MonoBehaviour
{
    [SerializeField] private float moveSpeed;
    
    private Rigidbody _physicsBody;
    private Vector2 _moveDirection;
    
    void Awake()
    {
        _physicsBody = GetComponent<Rigidbody>();
    }

    void Update()
    {
        if (Input.GetKey(KeyCode.W))
        {
            _moveDirection.y = 1;
        }
        if (Input.GetKey(KeyCode.S))
        {
            _moveDirection.y = -1;
        }
        if (Input.GetKey(KeyCode.A))
        {
            _moveDirection.x = -1;
        }
        if (Input.GetKey(KeyCode.D))
        {
            _moveDirection.x = 1;
        }
    }

    private void FixedUpdate()
    {
        _physicsBody.AddForce(new Vector3(_moveDirection.x, 0, _moveDirection.y) * (moveSpeed * Time.fixedDeltaTime), ForceMode.Force);
        _moveDirection = Vector2.zero;
    }
}

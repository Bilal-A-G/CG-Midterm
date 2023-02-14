Shader "Custom/Forcefield"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _NormalTex ("Normal Map (RGB)", 2D) = "white" {}
        _RimPower("Rim Power", float) = 1
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" }

        CGPROGRAM
        #pragma surface surf Standard noshadow alpha:blend
        
        sampler2D _MainTex;
        sampler2D _NormalTex;

        struct Input
        {
            float2 uv_MainTex;
            float3 viewDir;
        };

        half _Glossiness;
        half _Metallic;
        half _RimPower;
        fixed4 _Color;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;

            const float3 normal = UnpackNormal(tex2D(_NormalTex, IN.uv_MainTex)).rgb;

            const float rim = 1 - dot(normal, IN.viewDir);
            const float rimAmount = pow(rim, _RimPower);

            o.Emission = rimAmount * c.rgb;
            o.Alpha = rimAmount;
            o.Normal = normal;
        }
        ENDCG
    }
    FallBack "Diffuse"
}

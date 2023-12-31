Shader "Custom/NewSurfaceShader" 
{
    Properties
    {
        _PrimaryColor ("Primary color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
            float3 worldPos;
        };

        half _Glossiness;
        half _Metallic;
        //fixed4 _Color;
        fixed4 _PrimaryColor;
        //fixed4 _SecondaryColor;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _PrimaryColor;
            o.Albedo = c.xyz;
    
            float deltaTime = 2.0;
            //float currPos = (_Time.y % deltaTime) / deltaTime;
                float currPos2 = (1 - ((_Time.y % deltaTime) / deltaTime) * 2);
                float currPos2_abs = abs(currPos2);
                if (IN.worldPos.y + 0.5 < currPos2_abs)
                {
                    // Ini adalah warna dibawah garis
                    if (currPos2 > 0)
                    {
                        // Ini adalah warna ketika garis turun
                        o.Albedo = fixed3(1.0, 0.0, 0.0);
                    }
                    else
                    {
                        // Ini adalah warna ketika garis naik
                        o.Albedo = fixed3(0.0, 1.0, 0.0);
                    }
                }
                else
                {
                    // ini adalah warna diatas garis
                    if (currPos2 > 0)
                    {
                        // Ini adalah warna ketika garis turun
                        o.Albedo = fixed3(0.0, 1.0, 0.0);
                    }
                    else
                    {
                        // Ini adalah warna ketika garis naik
                        o.Albedo = fixed3(1.0, 0.0, 0.0);
                    }
                }
                // ini adalah garis
                if (abs(IN.worldPos.y + 0.5 - currPos2_abs) < 0.05)
                {
                    o.Albedo = fixed3(0.0, 0.0, 0.0);
                }
                
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
